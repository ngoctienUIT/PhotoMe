import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/other_profile/screen/other_profile_page.dart';
import 'package:photo_me/src/presentation/view_image/screen/view_image.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controls/function/route_function.dart';

class PostItem extends StatefulWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: const Color(0xFFF5F5F5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(
                    screen: const ViewPostPage(),
                    begin: const Offset(0, 1),
                  ));
                },
                child: infoPost(context),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Content"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const ViewImage(url: "assets/images/post.png"),
                          ));
                        },
                        child: Image.asset(
                          "assets/images/post.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: 10,
                          effect: const ScrollingDotsEffect(
                            // activeDotColor: Colors.red,
                            activeStrokeWidth: 2.6,
                            activeDotScale: 1.3,
                            maxVisibleDots: 5,
                            radius: 8,
                            spacing: 10,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  actionItem(FontAwesomeIcons.heart, 1, "Like", () {}),
                  actionItem(FontAwesomeIcons.comment, 1, "Comment", () {
                    Navigator.of(context).push(createRoute(
                      screen: const ViewPostPage(),
                      begin: const Offset(0, 1),
                    ));
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoPost(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 55,
          width: 55,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(
                    screen: const OtherProfilePage(),
                    begin: const Offset(0, 1),
                  ));
                },
                child: ClipOval(
                  child: Image.asset("assets/images/avatar.jpg", height: 50),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(
                  screen: const OtherProfilePage(),
                  begin: const Offset(0, 1),
                ));
              },
              child: const Text(
                "Trần Ngọc Tiến",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            const Text("3 giờ trước"),
          ],
        ),
        const Spacer(),
        PopupMenuButton<int>(
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          onSelected: (value) {
            switch (value) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                break;
            }
          },
          icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 20),
          itemBuilder: (context) {
            return [
              itemPopup(
                text: 'Chỉnh sửa',
                icon: FontAwesomeIcons.penToSquare,
                color: const Color.fromRGBO(59, 190, 253, 1),
                index: 0,
              ),
              itemPopup(
                text: 'Ai có thể xem',
                icon: FontAwesomeIcons.globe,
                color: const Color.fromRGBO(26, 191, 185, 1),
                index: 1,
              ),
              itemPopup(
                text: 'Xóa',
                icon: FontAwesomeIcons.trash,
                color: const Color.fromRGBO(26, 191, 185, 1),
                index: 2,
              ),
            ];
          },
        ),
      ],
    );
  }

  PopupMenuItem<int> itemPopup({
    required String text,
    required int index,
    required IconData icon,
    required Color color,
  }) {
    return PopupMenuItem<int>(
      value: index,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(text)
        ],
      ),
    );
  }

  Widget actionItem(
    IconData icon,
    int number,
    String text,
    VoidCallback onPress,
  ) {
    return Row(
      children: [
        InkWell(onTap: onPress, child: Icon(icon)),
        const SizedBox(width: 5),
        Text("$number $text")
      ],
    );
  }
}
