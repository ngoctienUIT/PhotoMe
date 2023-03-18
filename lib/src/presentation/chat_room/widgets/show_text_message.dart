import 'package:flutter/material.dart';

import 'message_widget.dart';

class ShowTextMessage extends StatelessWidget {
  const ShowTextMessage({Key? key, required this.check}) : super(key: key);
  final bool check;
  // final Messages messages;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      check: check,
      child: Container(
        alignment: check ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 2 / 3),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: check ? Colors.blue : Colors.grey,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Alo bạn ey",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
