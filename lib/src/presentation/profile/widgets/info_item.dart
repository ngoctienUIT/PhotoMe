import 'package:flutter/material.dart';

Widget infoItem(String text, int number, VoidCallback onPress) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onPress,
    child: SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            "$number",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(text),
        ],
      ),
    ),
  );
}
