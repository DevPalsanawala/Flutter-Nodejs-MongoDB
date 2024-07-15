import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/src/constants/api.dart';
import 'package:todoapp/src/controller/home/get_todo_controller.dart';

class AddToDoController extends GetxController {
  static AddToDoController get instance => Get.find();

  RxBool isNotvalidate = false.obs;

  final title = TextEditingController();
  final desc = TextEditingController();

  void clear() {
    title.clear();
    desc.clear();
  }

  addTODO(BuildContext context, String userId) async {
    final controller = Get.put(getTodoController(userId));

    try {
      if (title.text.isNotEmpty && desc.text.isNotEmpty) {
        var reqbody = {
          "userId": userId,
          "title": title.text,
          "desc": desc.text,
        };

        var response = await http
            .post(
          Uri.parse(addToDourl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqbody),
        )
            .timeout(const Duration(seconds: 10), onTimeout: () {
          return http.Response(
              'Error: Request timeout', 408); // Request Timeout status code
        });

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);

        if (response.statusCode == 200) {
          // Change to 201 for created
          if (jsonResponse['status']) {
            clear();
            Get.back();
            controller.getTodoList(userId);

            Fluttertoast.showToast(
              msg: "To-Do Added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0,
            );
          } else {
            showSnackBar(context, "Something went wrong!");
          }
        } else {
          handleResponseErrors(context, response);
        }
      } else {
        isNotvalidate.value = true;
      }
    } catch (e) {
      print("Exception during add TODO: $e");
      showSnackBar(context, "Error during adding TODO!");
    }
  }

  void handleResponseErrors(BuildContext context, http.Response response) {
    switch (response.statusCode) {
      case 400:
        showSnackBar(context, "Bad request. Missing required fields.");
        break;
      case 401:
        showSnackBar(context, "Unauthorized");
        break;
      case 403:
        showSnackBar(context, "Forbidden");
        break;
      case 404:
        showSnackBar(context, "Not found");
        break;
      case 408:
        showSnackBar(context, "Request timeout. Please try again later");
        break;
      case 500:
        showSnackBar(context, "Internal server error. Please try again later");
        break;
      case 503:
        showSnackBar(context, "Service unavailable. Please try again later");
        break;
      default:
        showSnackBar(context, "Something went wrong! Please try again later");
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 3000),
        content: Text(message),
      ),
    );
  }
}
