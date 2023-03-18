import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'item_popup.dart';

class OptionChat extends StatefulWidget {
  const OptionChat({Key? key}) : super(key: key);

  @override
  State<OptionChat> createState() => _OptionChatState();
}

class _OptionChatState extends State<OptionChat> {
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      onSelected: (value) {
        switch (value) {
          case 0:
            break;
          case 1:
            changeNickname();
            break;
          case 2:
            showDialogDelete();
            break;
          case 3:
            break;
        }
      },
      icon: const Icon(
        FontAwesomeIcons.ellipsisVertical,
        size: 20,
        color: Color.fromRGBO(34, 184, 190, 1),
      ),
      itemBuilder: (context) {
        return [
          itemPopup(
            text: 'Tắt thông báo',
            icon: FontAwesomeIcons.bellSlash,
            // : FontAwesomeIcons.solidBell,
            color: const Color.fromRGBO(59, 190, 253, 1),
            index: 0,
          ),
          itemPopup(
            text: 'Biệt danh',
            icon: FontAwesomeIcons.penToSquare,
            color: const Color.fromRGBO(59, 190, 253, 1),
            index: 1,
          ),
          itemPopup(
            text: 'Xóa đoạn chat',
            icon: FontAwesomeIcons.trash,
            color: const Color.fromRGBO(255, 113, 150, 1),
            index: 2,
          ),
          itemPopup(
            text: 'Chặn',
            icon: FontAwesomeIcons.ban,
            color: const Color.fromRGBO(252, 177, 188, 1),
            index: 3,
          ),
        ];
      },
    );
  }

  Future changeNickname() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Đổi biệt danh"),
          content: TextField(
            controller: _name,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy", style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok", style: TextStyle(fontSize: 16)),
            )
          ],
        );
      },
    );
  }

  Future showDialogDelete() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Xóa đoạn chat"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy", style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok", style: TextStyle(fontSize: 16)),
            )
          ],
        );
      },
    );
  }
}
