import 'package:flutter/material.dart';

import 'custom_text_input.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    this.controller,
    required this.title,
    this.onPress,
    this.typeInput,
  }) : super(key: key);
  final TextEditingController? controller;
  final String title;
  final VoidCallback? onPress;
  final List<TypeInput>? typeInput;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: Text(title)),
        const SizedBox(height: 10),
        CustomTextInput(
          hint: title,
          title: title.toLowerCase(),
          onPress: onPress,
          typeInput: typeInput,
          controller: controller,
        ),
      ],
    );
  }
}
