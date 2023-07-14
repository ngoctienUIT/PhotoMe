// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_me/src/core/utils/constants/app_images.dart';

class NotificationItem extends StatelessWidget {
  final bool isRead;
  final String imageUrl;
  final String name;
  final String action;
  final String postDescription;

  const NotificationItem({
    required this.isRead,
    required this.imageUrl,
    required this.name,
    required this.postDescription,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: !isRead ? const Color(0x88dfe3ee) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset(AppImages.imgNonAvatar),
                height: 48,
                width: 48,
                fit: BoxFit.fill,
              ),
            ),
            title: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' $action'),
                  TextSpan(
                      text: ' $postDescription',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // trailing: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
