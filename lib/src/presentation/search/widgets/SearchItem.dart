import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_me/src/data/model/user.dart';

class SearchItem extends StatelessWidget {
  final String imgUrl;
  final String name;

  const SearchItem({required this.imgUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    users.add(User(
        name: 'name',
        gender: true,
        description: 'description',
        avatar: 'avatar',
        birthday: DateTime(2002)));
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                imgUrl,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
