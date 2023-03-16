import 'package:flutter/material.dart';

Widget infoItem(String text, int number) {
  return SizedBox(
    width: 100,
    child: Column(
      children: [
        Text("$number"),
        const SizedBox(height: 5),
        Text(text),
      ],
    ),
  );
}
