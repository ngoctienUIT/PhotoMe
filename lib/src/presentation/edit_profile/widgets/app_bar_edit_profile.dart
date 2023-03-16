import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarEditProfile extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEditProfile({Key? key, required this.onSave}) : super(key: key);
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        child: const Icon(FontAwesomeIcons.xmark, color: Colors.black),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        InkWell(
          onTap: onSave,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(FontAwesomeIcons.check, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
