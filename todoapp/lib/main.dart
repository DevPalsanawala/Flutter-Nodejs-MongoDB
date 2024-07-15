import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/src/screens/home/home_screen.dart';
import 'package:todoapp/src/screens/login/login_screen.dart';
import 'package:todoapp/src/theme/theme.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDoApp',
      debugShowCheckedModeBanner: false,
      theme: DAppTheme.lighttheme,
      darkTheme: DAppTheme.darktheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 800),
      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else {
            if (snapshot.hasData &&
                snapshot.data != null &&
                !JwtDecoder.isExpired(snapshot.data!)) {
              return HomeScreen(token: snapshot.data!);
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
