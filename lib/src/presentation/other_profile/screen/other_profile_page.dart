import 'package:flutter/material.dart';
import 'package:photo_me/src/presentation/chat_room/screen/chat_room_page.dart';

import '../../../core/function/route_function.dart';
import '../../profile/widgets/info_item.dart';
import '../../view_follow/screen/view_follow_page.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
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
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                      ),
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
                      // Navigator.of(context).push(createRoute(
                      //   screen: const ViewPostPage(),
                      //   begin: const Offset(1, 0),
                      // ));
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
