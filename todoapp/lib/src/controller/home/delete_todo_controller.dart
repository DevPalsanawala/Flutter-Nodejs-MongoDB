import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/src/controller/home/get_todo_controller.dart';

class DeleteToDoController extends GetxController {
  static DeleteToDoController get instance => Get.find();

  Future<void> deleteTodo(id, userId) async {
    // print(id);

    final contoller = Get.put(getTodoController(userId));
    try {
      var reqbody = {"id": id};

      var response = await http.post(
        Uri.parse(deleteToDourl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqbody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']) {
          contoller.getTodoList(userId);
          Fluttertoast.showToast(
            msg: "To-Do Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else {
          print("Delete failed: ${jsonResponse['message']}");
          Fluttertoast.showToast(
            msg: jsonResponse['message'] ?? "Failed to delete To-Do",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Error during delete operation!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Exception during delete: $e");
      Fluttertoast.showToast(
        msg: "Error during delete operation!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    }
  }
}
