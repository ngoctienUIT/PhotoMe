import 'package:flutter/material.dart';

import '../../../controls/function/on_will_pop.dart';
import '../../../controls/function/route_function.dart';
import '../../main/screen/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(createRoute(
                    screen: const MainPage(),
                    begin: const Offset(1, 0),
                  ));
                },
                child: const Text("Go to Home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
