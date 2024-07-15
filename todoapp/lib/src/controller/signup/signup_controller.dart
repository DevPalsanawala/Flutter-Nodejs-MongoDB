import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/src/constants/api.dart';
import 'package:todoapp/src/screens/login/login_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  RxBool obsecure = true.obs;
  RxBool isNotvalidate = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  isvisible() {
    obsecure.value = !obsecure.value;
  }

  void clear() {
    email.clear();
    pass.clear();
  }

  Future<void> registerUser(BuildContext context) async {
    isLoading.value = true;
    try {
      if (email.text.isNotEmpty && pass.text.isNotEmpty) {
        var reqbody = {
          "email": email.text,
          "password": pass.text,
        };

        var response = await http.post(
          Uri.parse(registrationurl), // Replace with your registration URL
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqbody),
        );

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);

        if (jsonResponse['status']) {
          Get.to(() => const LoginScreen());
          clearFields();

          Fluttertoast.showToast(
            msg: "Account Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else {
          print("Something went wrong!");
          showSnackBar(context, "Something went wrong!");
        }
      } else {
        isNotvalidate.value = true;
      }
    } catch (e) {
      print("Exception during signup: $e");
      showSnackBar(context, "Error during signup!");
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    email.clear();
    pass.clear();
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
