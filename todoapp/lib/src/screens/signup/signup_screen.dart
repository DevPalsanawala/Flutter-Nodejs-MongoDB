import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todoapp/src/comman_widgets/formheader.dart';
import 'package:todoapp/src/constants/color.dart';
import 'package:todoapp/src/constants/size.dart';
import 'package:todoapp/src/controller/signup/signup_controller.dart';
import 'package:todoapp/src/screens/login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    final size = mediaquery.size;
    final brightness = mediaquery.platformBrightness;
    final isDarkmode = brightness == Brightness.dark;
    final controller = Get.put(SignupController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ddefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHeader(
                size: size,
                image: "assets/images/welcome.png",
                title: "Sign-up",
                subtitle: "Create your profile to start your journey... ",
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: dFormHeight - 10),
                child: Form(
                  child: Column(
                    children: [
                      const SizedBox(height: dFormHeight - 15),
                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 25),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.only(left: 15),
                          width: double.infinity,
                          child: controller.isNotvalidate.value
                              ? Text(
                                  "Enter Proper Email !",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 13, color: Colors.red),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 20),
                      Obx(
                        () => TextFormField(
                          controller: controller.pass,
                          obscureText: controller.obsecure.value,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.numbers_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isvisible();
                              },
                              icon: Icon(controller.obsecure.value
                                  ? LineAwesomeIcons.eye_solid
                                  : LineAwesomeIcons.eye_slash),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 25),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.only(left: 15),
                          width: double.infinity,
                          child: controller.isNotvalidate.value
                              ? Text(
                                  "Enter Proper Password !",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 13, color: Colors.red),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 10),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.registerUser(context);
                              FocusScope.of(context).unfocus();
                            },
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: isDarkmode
                                        ? dSecondaryColor
                                        : dPrimaryColor,
                                    strokeWidth: 3,
                                  )
                                : Text(
                                    "Signup".toUpperCase(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 20),
                      GestureDetector(
                        onTap: () => Get.to(const LoginScreen()),
                        child: Text.rich(
                          TextSpan(
                              text: "Already have an account?  ",
                              style: Theme.of(context).textTheme.bodyText1,
                              children: const [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
