import 'package:flutter/material.dart';
import 'package:photo_me/src/core/utils/constants/constants.dart';
import 'package:photo_me/src/presentation/signup/screen/signup_page.dart';

import '../../../core/function/on_will_pop.dart';
import '../../../core/function/route_function.dart';
import '../../main/screen/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? currentBackPressTime;
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // image, app text
                Padding(
                  padding:
                      const EdgeInsets.only(top: 80, right: 100, left: 100),
                  child: Image.asset(AppImages.imgLogoB),
                ),
                const Text(
                  "PhotoMe App",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // email
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: emailTextController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),

                //password
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    controller: passwordTextController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                ),

                //login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).pushReplacement(createRoute(
                        screen: const MainPage(),
                        begin: const Offset(0, 1),
                      ))
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),

                // forgot password

                GestureDetector(
                  onTap: () => {print("forgot password")},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      "Forgot password",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    ),
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "Don't have an account? Create here ",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),

                // dont have password
              ],
            ),
          ),
        ),
      ),
    );
  }
}
