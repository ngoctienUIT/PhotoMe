import 'package:flutter/material.dart';

Widget customButton({required VoidCallback onPress, required String text}) {
  return Container(
    width: double.infinity,
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
