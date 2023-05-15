import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/function/route_function.dart';
import 'package:photo_me/src/presentation/main/screen/main_page.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_bloc.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_state.dart';

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
    return BlocListener(
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
        appBar: AppBar(
          title: const Text('Create an account'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: emailTextController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.person)),
                ),
              ),

              //password
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextField(
                  controller: passwordTextController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Re-password",
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => {print("asd")},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),

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
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    "Have an account? Sign in",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
