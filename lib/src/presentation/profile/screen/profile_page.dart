import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/login/screen/login_page.dart';
import 'package:photo_me/src/presentation/message/screen/message_page.dart';
import 'package:photo_me/src/presentation/setting/screen/setting_page.dart';
import 'package:photo_me/src/presentation/view_follow/screen/view_follow_page.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';

import '../../../controls/function/route_function.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../widgets/info_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Spacer(),
            Divider(),
            ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () {
                  Navigator.of(context).pushReplacement(createRoute(
                    screen: const LoginPage(),
                    begin: const Offset(0, 1),
                  ));
                }),
            Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        // leading: InkWell(
        //   child: const Icon(FontAwesomeIcons.bars),
        //   onTap: () {
        //     Navigator.of(context).push(createRoute(
        //       screen: const SettingPage(),
        //       begin: const Offset(-1, 0),
        //     ));
        //   },
        // ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.of(context).push(createRoute(
        //         screen: const MessagePage(),
        //         begin: const Offset(1, 0),
        //       ));
        //     },
        //     child: const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 15),
        //       child: Icon(FontAwesomeIcons.paperPlane),
        //     ),
        //   ),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(90),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/avatar.jpg",
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Trần Ngọc Tiến",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              const Text("@ngoctienTNT"),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black54),
                ),
                onPressed: () {
                  Navigator.of(context).push(createRoute(
                    screen: const EditProfile(),
                    begin: const Offset(0, 1),
                  ));
                },
                child: const Text("Edit profile"),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoItem("Post", 0, () {}),
                  infoItem("Followers", 0, () {
                    Navigator.of(context).push(createRoute(
                      screen: const ViewFollowPage(index: 0),
                      begin: const Offset(1, 0),
                    ));
                  }),
                  infoItem("Following", 0, () {
                    Navigator.of(context).push(createRoute(
                      screen: const ViewFollowPage(index: 1),
                      begin: const Offset(1, 0),
                    ));
                  }),
                ],
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(createRoute(
                        screen: const ViewPostPage(),
                        begin: const Offset(1, 0),
                      ));
                    },
                    child: Image.asset(
                      "assets/images/avatar.jpg",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
