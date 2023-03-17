import 'package:flutter/material.dart';
import 'package:photo_me/src/presentation/chat_room/screen/chat_room_page.dart';
import 'package:photo_me/src/presentation/home/widgets/post_item.dart';

import '../../../controls/function/route_function.dart';
import '../../profile/widgets/info_item.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black54),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(createRoute(
                          screen: const ChatRoomPage(),
                          begin: const Offset(0, 1),
                        ));
                      },
                      child: const Text("Message"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {},
                      child: const Text("Follow"),
                    ),
                  ),
                  const Spacer(),
                ],
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
