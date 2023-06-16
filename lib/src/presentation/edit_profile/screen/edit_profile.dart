import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:photo_me/src/core/bloc/service_event.dart';
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

import '../../../core/bloc/service_bloc.dart';
import '../../../data/model/service_model.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ServiceModel serviceModel = context.read<ServiceBloc>().serviceModel;
    return BlocProvider(
      create: (context) => EditProfileBloc(serviceModel),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

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
  late UserResponse user;

  @override
  void initState() {
    user = context.read<ServiceBloc>().serviceModel.user!;
    nameController.text = user.name;
    birthdayController.text = user.birthday!;
    genderController.text = user.gender!;
    descriptionController.text = user.description!;
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
          context.read<ServiceBloc>().add(UpdateUserEvent(state.user));
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
                    avatar: image != null ? image!.path : user.avatar,
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
                  avatarWidget(),
                  const SizedBox(height: 30),
                  ProfileItem(
                    title: "Tên",
                    controller: nameController,
                    typeInput: const [TypeInput.text],
                  ),
                  const SizedBox(height: 20),
                  birthdayWidget(),
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
                      Expanded(child: genderWidget()),
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

  Widget avatarWidget() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          current is ChangeAvatarState || current is InitState,
      builder: (_, state) {
        return AvatarWidget(
          onChange: (image) {
            this.image = image;
            context.read<EditProfileBloc>().add(ChangeAvatarEvent());
          },
          image: image,
          avatar: user.avatar,
        );
      },
    );
  }

  Widget genderWidget() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          current is ChangeGenderState || current is InitState,
      builder: (_, state) {
        return GenderWidget(
          isPick: isPick,
          controller: genderController,
          onChange: (isPick) {
            this.isPick = isPick;
            context.read<EditProfileBloc>().add(ChangeGenderEvent());
          },
        );
      },
    );
  }

  Widget birthdayWidget() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          current is ChangeBirthDayState || current is InitState,
      builder: (_, state) {
        return ProfileItem(
          title: "Ngày sinh",
          controller: birthdayController,
          onPress: () => selectDate(),
        );
      },
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
      selectedDate = picked;
      birthdayController.text = DateFormat("dd/MM/yyyy").format(picked);
      if (context.mounted) {
        context.read<EditProfileBloc>().add(ChangeBirthDayEvent());
      }
    }
  }
}
