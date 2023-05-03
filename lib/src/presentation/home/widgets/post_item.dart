import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/presentation/home/widgets/image_widget.dart';
import 'package:photo_me/src/presentation/other_profile/screen/other_profile_page.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';

import '../../../core/function/route_function.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, this.post}) : super(key: key);

  final PostResponse? post;

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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(post != null ? post!.description : ""),
              ),
            ),
            if (post != null && post!.photo.isNotEmpty)
              ImageWidget(
                images: List.generate(
                    post!.photo.length, (index) => post!.photo[index]),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  actionItem(FontAwesomeIcons.heart,
                      post != null ? post!.liked.length : 0, "Like", () {}),
                  actionItem(FontAwesomeIcons.comment,
                      post != null ? post!.comment.length : 0, "Comment", () {
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
                  child: CachedNetworkImage(
                    imageUrl: post!.user.avatar,
                    height: 50,
                    width: 50,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/avatar.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
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
              child: Text(
                post != null ? post!.user.name : "",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Text(post != null ? post!.registration : ""),
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
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [Icon(icon), const SizedBox(width: 5), Text("$number $text")],
      ),
    );
  }
}
