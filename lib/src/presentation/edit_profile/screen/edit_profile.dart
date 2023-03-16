import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/app_bar_edit_profile.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/avatar_widget.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/custom_text_input.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/gender_widget.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/profile_item.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController wordController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool isPick = true;
  File? image;

  @override
  void dispose() {
    nameController.dispose();
    birthdayController.dispose();
    descriptionController.dispose();
    genderController.dispose();
    wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEditProfile(
        onSave: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pop(context);
          }
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AvatarWidget(
                  onChange: (image) => setState(() => this.image = image),
                  image: image,
                ),
                const SizedBox(height: 30),
                ProfileItem(
                  title: "Tên",
                  controller: nameController,
                  typeInput: const [TypeInput.text],
                ),
                const SizedBox(height: 20),
                ProfileItem(
                  title: "Ngày sinh",
                  controller: birthdayController,
                  onPress: () => selectDate(),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Mô tả"),
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: descriptionController,
                  hint: "Mô tả",
                  maxLines: 5,
                  contentPadding: const EdgeInsets.all(10),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GenderWidget(
                        isPick: isPick,
                        controller: genderController,
                        onChange: (isPick) =>
                            setState(() => this.isPick = isPick),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Công việc"),
                          ),
                          const SizedBox(height: 10),
                          CustomTextInput(
                            controller: wordController,
                            hint: "Công việc",
                            onPress: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdayController.text = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }
}
