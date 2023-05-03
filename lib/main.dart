import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/utils/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/core/language/bloc/language_cubit.dart';
import 'src/core/language/bloc/language_state.dart';
import 'src/core/language/localization/app_localizations_setup.dart';
import 'src/presentation/login/screen/login_page.dart';

int? language;
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NGU2YTg2YTgwYTg1MjgzNTk4N2JkNyIsImlhdCI6MTY4MzAzNDU3NSwiZXhwIjoxNzE0NTcwNTc1fQ.aHC6R6r_w6bdJFQlztPnmIJsQu6wBmRE4ez1y9L_hTQ";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  language = prefs.getInt('language');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit(language: language),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        buildWhen: (previous, current) => previous != current,
        builder: (_, settingState) {
          return MaterialApp(
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            locale: settingState.locale,
            debugShowCheckedModeBanner: false,
            title: 'PhotoMe',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                foregroundColor: Colors.black,
                centerTitle: true,
              ),
            ),
            home: AnimatedSplashScreen(
              nextScreen: const LoginPage(),
              splash: AppImages.imgLogoB,
              splashIconSize: 250,
            ),
          );
        },
      ),
    );
  }
}
