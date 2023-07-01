import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/bloc/service_event.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';

import '../../../core/bloc/service_bloc.dart';
import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../data/model/service_model.dart';
import '../../login/widget/custom_button.dart';
import '../../login/widget/custom_password_input.dart';
import '../bloc/change_password_bloc.dart';
import '../bloc/change_password_event.dart';
import '../bloc/change_password_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceModel serviceModel = context.read<ServiceBloc>().serviceModel;
    return BlocProvider(
      create: (context) => ChangePasswordBloc(serviceModel),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("change_password".translate(context)),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: ChangePasswordView(),
        ),
      ),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isContinue = false;
  bool hide = true;
  ServiceModel serviceModel = ServiceModel();

  @override
  void initState() {
    oldPasswordController.addListener(() => checkEmpty());
    newPasswordController.addListener(() => checkEmpty());
    confirmPasswordController.addListener(() => checkEmpty());
    confirmPasswordController.addListener(() {
      context.read<ChangePasswordBloc>().add(TextChangeEvent());
    });
    newPasswordController.addListener(() {
      context.read<ChangePasswordBloc>().add(TextChangeEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkEmpty() {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      context
          .read<ChangePasswordBloc>()
          .add(ShowChangeButtonEvent(isContinue: true));
    } else {
      context
          .read<ChangePasswordBloc>()
          .add(ShowChangeButtonEvent(isContinue: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    serviceModel = context.read<ServiceBloc>().serviceModel;
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          customToast(
              context, "change_password_successfully".translate(context));
          context.read<ServiceBloc>().add(UpdateUserEvent(
              serviceModel.user!.copyWith(password: state.newPassword)));
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is ChangePasswordErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
        if (state is ChangePasswordLoadingState) {
          loadingAnimation(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "change_password".translate(context),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          passwordInput(),
          const Spacer(),
          changePasswordButton(),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget passwordInput() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          current is HidePasswordState || current is TextChangeState,
      builder: (context, state) {
        return Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomPasswordInput(
                    controller: oldPasswordController,
                    hint: "enter_the_old_password".translate(context),
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please_enter_your_old_password"
                            .translate(context);
                      }
                      final bool checkPassword = BCrypt.checkpw(
                        oldPasswordController.text,
                        serviceModel.user!.password!,
                      );
                      if (!checkPassword) {
                        return "old_password_is_incorrect".translate(context);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordInput(
                    controller: newPasswordController,
                    hint: "enter_new_password".translate(context),
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return "password_does_not_match".translate(context);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordInput(
                    controller: confirmPasswordController,
                    confirmPassword: newPasswordController.text,
                    hint: "confirm_password".translate(context),
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return "password_does_not_match".translate(context);
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void changeHide() {
    context.read<ChangePasswordBloc>().add(HidePasswordEvent(isHide: !hide));
    hide = !hide;
  }

  Widget changePasswordButton() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: "change_password".translate(context),
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context
                  .read<ChangePasswordBloc>()
                  .add(ClickChangePasswordEvent(newPasswordController.text));
            }
          },
        );
      },
    );
  }
}
