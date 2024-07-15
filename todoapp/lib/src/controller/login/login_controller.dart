import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/src/constants/api.dart';
import 'package:todoapp/src/screens/home/home_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  late SharedPreferences preferences;

  RxBool isNotvalidate = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  RxBool obsecure = true.obs;
  isvisible() {
    obsecure.value = !obsecure.value;
  }

  void clear() {
    email.clear();
    pass.clear();
  }

  Future<void> login(BuildContext context) async {
    isLoading.value = true;
    try {
      if (email.text.isNotEmpty && pass.text.isNotEmpty) {
        var reqbody = {
          "email": email.text,
          "password": pass.text,
        };

        var response = await http
            .post(
          Uri.parse(loginurl), // Replace with your login URL
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqbody),
        )
            .timeout(const Duration(seconds: 10), onTimeout: () {
          return http.Response(
              'Error: Request timeout', 408); // Request Timeout status code
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(
              "status: ${jsonResponse['status']} \ntoken: ${jsonResponse['token']}");

          if (jsonResponse['status']) {
            // Store token in SharedPreferences
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setString('token', jsonResponse['token']);

            Get.offAll(() => HomeScreen(
                  token: jsonResponse['token'],
                ));
            clearFields();
            Fluttertoast.showToast(
              msg: "Login successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0,
            );
          } else {
            print("Login failed: ${jsonResponse['message']}");
            showSnackBar(context, "Login failed");
          }
        } else {
          if (response.statusCode == 404) {
            showSnackBar(context, "User not found");
          }
          if (response.statusCode == 401) {
            showSnackBar(context, "Password is incorrect");
          }
          if (response.statusCode == 500) {
            showSnackBar(
                context, "Something went wrong! Please try again later");
          }
          if (response.statusCode == 408) {
            showSnackBar(context, "Something went wrong!");
          }
        }
      } else {
        isNotvalidate.value = true;
      }
    } catch (e) {
      print("Exception during login: $e");
      showSnackBar(context, "Error during login!");
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
        duration: const Duration(milliseconds: 3000),
        content: Text(message),
      ),
    );
  }
}
