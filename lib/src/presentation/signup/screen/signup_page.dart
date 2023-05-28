import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/function/route_function.dart';
import 'package:photo_me/src/presentation/login/screen/login_page.dart';
import 'package:photo_me/src/presentation/main/screen/main_page.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_bloc.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_state.dart';

import '../../../core/utils/constants/app_images.dart';
import '../../edit_profile/widgets/custom_text_input.dart';
import '../../login/widget/custom_button.dart';

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
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  int group = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.of(context).pushReplacement(createRoute(
            screen: const MainPage(),
            begin: const Offset(0, 1),
          ));
        }
        if (state is SignupError) {
          final snackBar = SnackBar(
            content: const Text('Error'),
            action: SnackBarAction(
              label: 'Error nào thì không biết',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      const EdgeInsets.only(top: 80, right: 100, left: 100),
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
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextInput(
                    controller: emailTextController,
                    hint: "Email",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextInput(
                    controller: passwordTextController,
                    hint: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextInput(
                    controller: confirmPasswordController,
                    hint: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Row(
                //   children: [
                //     Expanded(
                //       child: RadioListTile(
                //         value: 0,
                //         groupValue: group,
                //         onChanged: (value) => {},
                //         title: const Text("Male"),
                //       ),
                //     ),
                //     Expanded(
                //       child: RadioListTile(
                //         value: 0,
                //         groupValue: group,
                //         onChanged: (value) => {},
                //         title: const Text("Female"),
                //       ),
                //     )
                //   ],
                // ),
                customButton(
                  text: "Sign up",
                  onPress: () {},
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: "By registering, you confirm that you accept our ",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Term of service',
                            style: TextStyle(color: Colors.amber)),
                        TextSpan(text: ' and '),
                        TextSpan(
                            text: 'Privacy policy',
                            style: TextStyle(color: Colors.amber)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    print('asasdasd'),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    ),
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "Have an account? Sign in",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
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
