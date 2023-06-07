import 'package:flutter/material.dart';

void loadingAnimation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Center(child: CircularProgressIndicator()),
      );
    },
  );
}
