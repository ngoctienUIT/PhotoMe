import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/home/widgets/post_item.dart';
import 'package:photo_me/src/presentation/message/screen/message_page.dart';
import 'package:photo_me/src/presentation/setting/screen/setting_page.dart';

import '../../../controls/function/route_function.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../widgets/info_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          child: const Icon(FontAwesomeIcons.bars, color: Colors.black),
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: const SettingPage(),
              begin: const Offset(-1, 0),
            ));
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const MessagePage(),
                begin: const Offset(1, 0),
              ));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(FontAwesomeIcons.paperPlane, color: Colors.black),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                  infoItem("Post", 0),
                  infoItem("Followers", 0),
                  infoItem("Following", 0),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: const [
                      SizedBox(height: 20),
                      PostItem(),
                    ],
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
