import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todoapp/src/constants/api.dart';

class getTodoController extends GetxController {
  static getTodoController get instance => Get.find();

  String id;
  getTodoController(this.id);
  var items = [].obs; // RxList to store the list of todo items
  @override
  void onInit() {
    getTodoList(id);
    super.onInit();
  }

  void getTodoList(String userId) async {
    try {
      var regBody = {
        "userId": userId,
      };
      var response = await http.post(
        Uri.parse(getuserToDourl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']) {
          items.assignAll(
              jsonResponse['success']); // Update items with response data
        } else {
          print("Error: ${jsonResponse['message']}");
          Fluttertoast.showToast(
            msg: jsonResponse['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      } else {
        if (response.statusCode == 500) {
          Fluttertoast.showToast(
            msg: "Error fetching todos",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print("Exception during fetching todos: $e");
      Fluttertoast.showToast(
        msg: "Error fetching todos",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    }
  }
}
