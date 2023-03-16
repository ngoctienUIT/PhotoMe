import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          onTap: () {},
        ),
      ),
      body: SafeArea(
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text("@ngoctienTNT"),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoItem("Post", 0),
                infoItem("Followers", 0),
                infoItem("Following", 0),
              ],
            ),
            const SizedBox(height: 20),
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
            )
          ],
        ),
      ),
    );
  }
}
