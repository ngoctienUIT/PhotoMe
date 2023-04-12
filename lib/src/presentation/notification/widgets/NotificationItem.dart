// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String action;

  const NotificationItem(
      {required this.imageUrl, required this.name, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                imageUrl,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: " $action",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
