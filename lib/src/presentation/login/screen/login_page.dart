import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/bloc/service_bloc.dart';
import 'package:photo_me/src/core/bloc/service_event.dart';
import 'package:photo_me/src/core/function/route_function.dart';
import 'package:photo_me/src/core/utils/constants/constants.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/data/model/service_model.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/custom_text_input.dart';
import 'package:photo_me/src/presentation/login/bloc/login_bloc.dart';
import 'package:photo_me/src/presentation/login/bloc/login_event.dart';
import 'package:photo_me/src/presentation/login/bloc/login_state.dart';
import 'package:photo_me/src/presentation/login/widget/custom_button.dart';
import 'package:photo_me/src/presentation/main/screen/main_page.dart';

import '../../../core/function/on_will_pop.dart';
import '../../signup/screen/signup_page.dart';
import '../widget/custom_password_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(), //..add(Init()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  DateTime? currentBackPressTime;
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        print(state);
        if (state is LoginSuccess) {
          context.read<ServiceBloc>().add(SetServiceModel(
              ServiceModel(user: state.user, token: state.token)));
          Navigator.of(context).pushAndRemoveUntil(
            createRoute(
              screen: const MainPage(),
              begin: const Offset(0, 1),
            ),
            (route) => false,
          );
        }
        if (state is LoginError) {
          final snackBar = SnackBar(
            content: Text(state.error),
            action: SnackBarAction(
              label: "ok",
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => onWillPop(
            action: (now) => currentBackPressTime = now,
            currentBackPressTime: currentBackPressTime,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                child: Column(
                  children: [
                    // image, app text
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
                    // email
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomTextInput(
                        controller: emailTextController,
                        hint: "Email",
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "forgot_password".translate(context),
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //login button
                    customButton(
                      text: "sign_in".translate(context),
                      onPress: () {
                        context.read<LoginBloc>().add(Login(
                            emailTextController.text,
                            passwordTextController.text));
                      },
                    ),
                    // forgot password
                    GestureDetector(
                      onTap: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        ),
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          "don_have_an_account".translate(context),
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                    // dont have password
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
