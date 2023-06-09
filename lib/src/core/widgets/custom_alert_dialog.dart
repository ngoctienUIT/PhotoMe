import 'package:flutter/material.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';

AlertDialog customAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onOK,
}) {
  return AlertDialog(
    title: Center(child: Text(title)),
    content: Text(content),
    actions: [
      IntrinsicHeight(
        child: Row(
          children: [
            const Spacer(),
            TextButton(
              child: Text(
                'cancel'.translate(context),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
            const VerticalDivider(
              color: Colors.red,
              thickness: 1,
              endIndent: 5,
              indent: 5,
            ),
            const Spacer(),
            TextButton(
              onPressed: onOK,
              child: Text(
                'ok'.translate(context),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      )
    ],
  );
}
