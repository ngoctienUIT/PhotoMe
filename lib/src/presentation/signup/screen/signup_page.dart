import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/function/custom_toast.dart';
import 'package:photo_me/src/core/function/route_function.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/presentation/login/screen/login_page.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_bloc.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_state.dart';

import '../../../core/utils/constants/app_images.dart';
import '../../edit_profile/widgets/custom_text_input.dart';
import '../../login/widget/custom_button.dart';
import '../../login/widget/custom_password_input.dart';
import '../bloc/signup_event.dart';

// enum SingingCharacter { Ma }
class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignupBloc(),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? gender = 'male';
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.of(context).pushReplacement(createRoute(
            screen: const LoginPage(),
            begin: const Offset(0, 1),
          ));
        }
        if (state is SignupError) {
          customToast(context, state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50, right: 100, left: 100),
                  child: Image.asset(AppImages.imgLogoB, height: 120),
                ),
                const SizedBox(height: 20),

                const Text(
                  "PhotoMe App",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: CustomTextInput(
                    controller: nameController,
                    hint: "name".translate(context),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                // GenderWidget(
                //   isPick: isPick,
                //   controller: genderController,
                //   onChange: (isPick) {
                //     setState(() {
                //       this.isPick = isPick;
                //     });
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextInput(
                    controller: emailTextController,
                    hint: "Email",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextInput(
                    controller: phoneTextController,
                    hint: "phone_number".translate(context),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomPasswordInput(
                    controller: passwordTextController,
                    hint: "password".translate(context),
                    prefixIcon: const Icon(Icons.lock),
                    hide: hide,
                    onPress: () => setState(() => hide = !hide),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomPasswordInput(
                    controller: confirmPasswordController,
                    hint: "password".translate(context),
                    prefixIcon: const Icon(Icons.lock),
                    hide: hide,
                    onPress: () => setState(() => hide = !hide),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) => {
                          setState(() {
                            gender = value;
                          })
                        },
                        title: Text("male".translate(context)),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) => {
                          setState(() {
                            gender = value;
                          })
                        },
                        title: Text("female".translate(context)),
                      ),
                    )
                  ],
                ),
                customButton(
                  text: "sign_up".translate(context),
                  onPress: () {
                    context.read<SignupBloc>().add(Signup(
                          emailTextController.text,
                          nameController.text,
                          gender ?? "",
                          phoneTextController.text,
                          passwordTextController.text,
                          confirmPasswordController.text,
                        ));
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => {
                    print('asasdasd'),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    ),
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "have_an_account".translate(context),
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
