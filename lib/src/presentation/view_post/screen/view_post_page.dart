import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/home/widgets/post_item.dart';

class ViewPostPage extends StatelessWidget {
  const ViewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "Trần Ngọc Tiến",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const PostItem(),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    commentItem(),
                    const SizedBox(height: 15),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget commentItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            "assets/images/avatar.jpg",
            height: 50,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Trần Ngọc Tiến",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                  "Trần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc TiếnTrần Ngọc Tiến"),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text("8 giờ trước"),
                  const SizedBox(width: 10),
                  InkWell(onTap: () {}, child: const Text("Trả lời")),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Icon(FontAwesomeIcons.heart),
                  ),
                  const SizedBox(width: 3),
                  const Text("10"),
                  const SizedBox(width: 25),
                  InkWell(
                    onTap: () {},
                    child: const Icon(FontAwesomeIcons.thumbsDown),
                  ),
                  const SizedBox(width: 3),
                  const Text("10"),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
