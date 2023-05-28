import 'package:flutter/material.dart';
import 'package:photo_me/src/presentation/login/screen/login_page.dart';
import 'package:photo_me/src/presentation/login/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cài đặt"),
      ),
      body: Column(
        children: [
          customButton(
            text: "Đăng xuất",
            onPress: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString("token", "");
              prefs.setString("userID", "");
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  createRoute(
                    screen: const LoginPage(),
                    begin: const Offset(0, 1),
                  ),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
