import 'package:flutter/material.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/profile_item.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/title_bottom_sheet.dart';

import 'gender_item.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    Key? key,
    required this.isPick,
    required this.controller,
    required this.onChange,
  }) : super(key: key);

  final bool isPick;
  final TextEditingController controller;
  final Function(bool isPick) onChange;

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      title: "Giới tính",
      controller: controller,
      onPress: () => showGenderBottomSheet(context),
    );
  }

  void showGenderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              titleBottomSheet(
                "choose_gender".translate(context),
                () => Navigator.pop(context),
              ),
              const Divider(color: Colors.black),
              GenderItem(
                gender: "male".translate(context),
                image: "assets/images/icon/male.png",
                onPress: () {
                  onChange(true);
                  controller.text = "male".translate(context);
                  Navigator.pop(context);
                },
                isPick: isPick,
              ),
              GenderItem(
                gender: "female".translate(context),
                image: "assets/images/icon/female.png",
                onPress: () {
                  onChange(false);
                  controller.text = "female".translate(context);
                  Navigator.pop(context);
                },
                isPick: !isPick,
              ),
            ],
          ),
        );
      },
    );
  }
}
