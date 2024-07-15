import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todoapp/src/constants/color.dart';
import 'package:todoapp/src/constants/size.dart';
import 'package:todoapp/src/controller/home/add_todo_controller.dart';
import 'package:todoapp/src/controller/home/delete_todo_controller.dart';
import 'package:todoapp/src/controller/home/get_todo_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, @required this.token});

  final token;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jwtToken = JwtDecoder.decode(token);
    final id = jwtToken['_id'];
    final email = jwtToken['email'];
    var mediaquery = MediaQuery.of(context);
    final size = mediaquery.size;
    final brightness = mediaquery.platformBrightness;
    final isDarkmode = brightness == Brightness.dark;
    final controller = Get.put(getTodoController(id));
    final deletcontroller = Get.put(DeleteToDoController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkmode ? dSecondaryColor : dPrimaryColor,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isDarkmode ? dSecondaryColor : dPrimaryColor),
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: ddefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor:
                            isDarkmode ? dPrimaryColor : dSecondaryColor,
                        foregroundColor:
                            isDarkmode ? dSecondaryColor : Colors.white,
                        child:
                            const Icon(LineAwesomeIcons.list_solid, size: 30),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // controller.deleteTokenFromPreferences();
                        },
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor:
                              isDarkmode ? dPrimaryColor : dSecondaryColor,
                          foregroundColor:
                              isDarkmode ? dSecondaryColor : Colors.white,
                          child: const Icon(LineAwesomeIcons.sign_out_alt_solid,
                              size: 30),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ddefaultSize),
                  Text(
                    "TO-DO With Nodejs + MongoDB",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: ddefaultSize - 20),
                  Text(
                    "5 Task",
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: ddefaultSize - 25),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      email,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(
                    top: isDarkmode
                        ? const BorderSide(width: 3, color: dPrimaryColor)
                        : const BorderSide(width: 3, color: dSecondaryColor),
                  ),
                  color: isDarkmode
                      ? Colors.black38.withOpacity(0.38)
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Obx(() {
                  if (controller.items.isEmpty) {
                    return Center(
                      child: Text(
                        "No To-Do Yet",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.red,
                                  icon: LineAwesomeIcons.trash_solid,
                                  label: "Delete",
                                  onPressed: (BuildContext context) {
                                    // print(controller.items[index]['_id']);
                                    deletcontroller.deleteTodo(
                                        controller.items[index]['_id'], id);
                                  },
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  border: isDarkmode
                                      ? Border.all(color: dPrimaryColor)
                                      : Border.all(color: dSecondaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                  color: isDarkmode
                                      ? dSecondaryColor
                                      : Colors.green[100],
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                      LineAwesomeIcons.pen_nib_solid,
                                      size: 30),
                                  title: Text(
                                    controller.items[index]['title'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    controller.items[index]['desc'],
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  trailing: const Icon(
                                      LineAwesomeIcons.arrow_left_solid),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: dPrimaryColor,
          foregroundColor: dSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            _displayTextInputDialog(context, id, isDarkmode);
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}

Future<void> _displayTextInputDialog(BuildContext context, id, isdark) {
  final controller = Get.put(AddToDoController());
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isdark ? dSecondaryColor : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add To-Do",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: dFormHeight - 15),
                const Divider(
                  height: 3,
                  color: dPrimaryColor,
                ),
                const SizedBox(height: dFormHeight - 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: controller.title,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        prefixIcon: Icon(LineAwesomeIcons.tags_solid),
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.only(left: 15),
                        width: double.infinity,
                        child: controller.isNotvalidate.value
                            ? Text(
                                "Enter Proper Data!",
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 13, color: Colors.red),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: dFormHeight - 15),
                    TextFormField(
                      controller: controller.desc,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        prefixIcon: Icon(LineAwesomeIcons.edit),
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.only(left: 15),
                        width: double.infinity,
                        child: controller.isNotvalidate.value
                            ? Text(
                                "Enter Proper Data!",
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 13, color: Colors.red),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: dFormHeight - 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addTODO(context, id);
                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          "Add".toUpperCase(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
