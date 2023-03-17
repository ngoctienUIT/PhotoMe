import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Chat", style: TextStyle(color: Colors.black)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return itemChat(context);
          },
        ),
      ),
    );
  }

  Widget itemChat(BuildContext context) {
    return InkWell(
      onTap: () {},
      onLongPress: () => showOptionChat(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Image.asset("assets/images/avatar.jpg", height: 50),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Trần Ngọc Tiến",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat.jm().format(DateTime.now()),
                        style: const TextStyle(color: Colors.black38),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Alo",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showOptionChat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: itemSettingChat(
                  onPress: () {},
                  icon:
                      FontAwesomeIcons.bell, //     ? FontAwesomeIcons.bellSlash
                  text: 'Tắt thông báo',
                  color: const Color.fromRGBO(59, 190, 253, 1),
                ),
              ),
              Expanded(
                child: itemSettingChat(
                  onPress: () {},
                  icon: FontAwesomeIcons.trash,
                  text: 'Xóa đoạn chat',
                  color: const Color.fromRGBO(255, 113, 150, 1),
                ),
              ),
              Expanded(
                child: itemSettingChat(
                  onPress: () {},
                  icon: FontAwesomeIcons.ban,
                  text: 'Chặn',
                  color: const Color.fromRGBO(252, 177, 188, 1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget itemSettingChat({
    required VoidCallback onPress,
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, color: color),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
