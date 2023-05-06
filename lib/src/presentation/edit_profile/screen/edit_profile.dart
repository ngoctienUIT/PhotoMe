import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:photo_me/src/core/function/loading_animation.dart';
import 'package:photo_me/src/data/model/user.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/app_bar_edit_profile.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/avatar_widget.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/custom_text_input.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/gender_widget.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/profile_item.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: EditProfileView(user: user),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController workController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool isPick = true;
  File? image;

  @override
  void initState() {
    nameController.text = widget.user.name;
    birthdayController.text = widget.user.birthday!;
    genderController.text = widget.user.gender!;
    descriptionController.text = widget.user.description!;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthdayController.dispose();
    descriptionController.dispose();
    genderController.dispose();
    workController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is UpdateLoading) {
          loadingAnimation(context);
        }
        if (state is UpdateSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBarEditProfile(
          onSave: () {
            if (_formKey.currentState!.validate()) {
              context.read<EditProfileBloc>().add(UpdateProfileEvent(User(
                    name: nameController.text,
                    gender: genderController.text,
                    description: descriptionController.text,
                    avatar: image != null ? image!.path : widget.user.avatar,
                    birthday: selectedDate,
                    job: workController.text,
                  )));
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
                    avatar: widget.user.avatar,
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
                              controller: workController,
                              hint: "Công việc",
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
