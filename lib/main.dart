import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:photo_me/src/core/utils/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'firebase_options.dart';
import 'src/core/language/bloc/language_bloc.dart';
import 'src/core/language/bloc/language_state.dart';
import 'src/core/language/localization/app_localizations_setup.dart';
import 'src/presentation/login/screen/login_page.dart';

int? language;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   if (!kIsWeb) {
//     await setupFlutterNotifications();
//   }
//
//   runApp(MessagingExampleApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  final prefs = await SharedPreferences.getInstance();
  language = prefs.getInt('language');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc(language: language),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
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
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
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
