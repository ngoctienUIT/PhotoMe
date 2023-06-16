import 'package:flutter/material.dart';
import 'package:photo_me/src/presentation/change_password/screen/change_password_page.dart';
import 'package:photo_me/src/presentation/login/screen/login_page.dart';
import 'package:photo_me/src/presentation/login/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/route_function.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../../info/screen/info_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text("Cài đặt")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 5),
                  child: Text("Tài khoản", style: TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      settingItem(() {
                        Navigator.of(context).push(createRoute(
                          screen: const EditProfile(),
                          begin: const Offset(1, 0),
                        ));
                      }, Icons.person, "Tài khoản"),
                      const SizedBox(height: 20),
                      settingItem(
                        () {
                          Navigator.of(context).push(createRoute(
                            screen: const ChangePasswordPage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        Icons.lock_outline_rounded,
                        "Đổi mật khẩu",
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        () async {
                          return showDialog(
                            context: context,
                            // barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return customAlertDialog(
                                context: context,
                                title: "Xóa tài khoản",
                                content: "Bạn muốn xóa tài khoản này",
                                onOK: () {},
                              );
                            },
                          );
                        },
                        Icons.delete,
                        "Xóa tài khoản",
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 5),
                  child: Text("Thông tin", style: TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      settingItem(
                        () {},
                        Icons.policy_rounded,
                        "Điều khoản và dịch vụ",
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        () {
                          Navigator.of(context).push(createRoute(
                            screen: const InfoPage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        Icons.info_outline_rounded,
                        "Thông tin ứng dụng",
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
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

  Widget settingItem(VoidCallback onTap, IconData icon, String text) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, color: const Color(0xFFadadad), size: 30),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
