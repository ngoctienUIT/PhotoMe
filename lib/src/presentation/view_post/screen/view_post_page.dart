import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/custom_text_input.dart';
import 'package:photo_me/src/presentation/home/widgets/post_item.dart';

class ViewPostPage extends StatelessWidget {
  const ViewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trần Ngọc Tiến")),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
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
                      commentItem(context),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black26, width: 0.5)),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                "assets/images/avatar.jpg",
                height: 50,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextInput(
                hint: "Thêm bình luận",
                radius: 30,
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: InkWell(
                  onTap: () {},
                  child: const Icon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showSimpleDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            // title: const Text('Select Booking Type'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Gửi đến bạn bè',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sao chép',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Xóa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }

  Widget commentItem(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showSimpleDialog(context);
      },
      child: Row(
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
      ),
    );
  }
}
