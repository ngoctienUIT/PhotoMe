import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'option_chat.dart';
import 'title_widget.dart';

class TitleChat extends StatelessWidget {
  const TitleChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 25,
      // titleSpacing: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color.fromRGBO(150, 150, 150, 1),
        ),
      ),
      title: const TitleWidget(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.phone,
            size: 20,
            color: Color.fromRGBO(34, 184, 190, 1),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.video,
            size: 20,
            color: Color.fromRGBO(34, 184, 190, 1),
          ),
        ),
        const OptionChat(),
      ],
    );
  }
}
