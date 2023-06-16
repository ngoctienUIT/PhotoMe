import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../login/widget/custom_button.dart';
import '../../login/widget/custom_password_input.dart';
import '../bloc/change_password_bloc.dart';
import '../bloc/change_password_event.dart';
import '../bloc/change_password_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Đổi mật khẩu"),
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
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          customToast(context, "Đổi mật khẩu thành công");
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
          const Text(
            "Đổi mật khẩu",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("password_needs_characters"),
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
            CustomPasswordInput(
              controller: oldPasswordController,
              hint: "enter_old_password",
              hide: state is HidePasswordState ? state.isHide : hide,
              onPress: () => changeHide(),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomPasswordInput(
                    controller: newPasswordController,
                    hint: "enter_new_password",
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordInput(
                    controller: confirmPasswordController,
                    confirmPassword: newPasswordController.text,
                    hint: "confirm_password",
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
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
          text: "change_password",
          onPress: () {
            if (_formKey.currentState!.validate()) {}
          },
        );
      },
    );
  }
}
