import 'package:flutter/material.dart';
import 'package:photo_me/src/presentation/notification/widgets/NotificationItem.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            NotificationItem(
                imageUrl: "assets/images/avatar.jpg",
                name: 'hang123',
                action: 'has commented in your post'),
            NotificationItem(
                imageUrl: "assets/images/avatar.jpg",
                name: 'hang123',
                action: 'has commented in your post'),
            NotificationItem(
                imageUrl: "assets/images/avatar.jpg",
                name: 'hang123',
                action: 'has commented in your post'),
            NotificationItem(
                imageUrl: "assets/images/avatar.jpg",
                name: 'hang123',
                action: 'has commented in your post'),
            NotificationItem(
                imageUrl: "assets/images/avatar.jpg",
                name: 'hang123',
                action: 'has commented in your post'),
          ],
        ),
      ),
    );
  }
}
