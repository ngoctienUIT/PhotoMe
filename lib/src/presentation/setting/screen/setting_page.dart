import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/function/loading_animation.dart';
import 'package:photo_me/src/core/language/bloc/language_bloc.dart';
import 'package:photo_me/src/core/language/bloc/language_event.dart';
import 'package:photo_me/src/core/language/bloc/language_state.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/presentation/change_password/screen/change_password_page.dart';
import 'package:photo_me/src/presentation/login/screen/login_page.dart';
import 'package:photo_me/src/presentation/login/widget/custom_button.dart';
import 'package:photo_me/src/presentation/policy/screen/policy_page.dart';
import 'package:photo_me/src/presentation/setting/bloc/setting_bloc.dart';
import 'package:photo_me/src/presentation/setting/bloc/setting_event.dart';
import 'package:photo_me/src/presentation/setting/bloc/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/bloc/service_bloc.dart';
import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_images.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/model/service_model.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../../edit_profile/widgets/title_bottom_sheet.dart';
import '../../info/screen/info_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    ServiceModel serviceModel = context.read<ServiceBloc>().serviceModel;
    return BlocProvider(
      create: (_) => SettingBloc(serviceModel),
      child: const SettingView(),
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is LoadingState) {
          loadingAnimation(context);
        }
        if (state is SuccessState) {
          customToast(
              context, "account_deleted_successfully".translate(context));
          Navigator.of(context).pushAndRemoveUntil(
            createRoute(
              screen: const LoginPage(),
              begin: const Offset(0, 1),
            ),
            (route) => false,
          );
        }
        if (state is ErrorState) {
          customToast(context, state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0, title: Text("setting".translate(context))),
        body: Column(
          children: [
            accountWidget(context),
            settingWidget(),
            infoWidget(context),
            const SizedBox(height: 10),
            customButton(
              text: "log_out".translate(context),
              onPress: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("token", "");
                prefs.setString("userID", "");
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    createRoute(
                      screen: const LoginPage(),
                      begin: const Offset(0, 1),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget accountWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 5),
            child: Text(
              "account".translate(context),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                const SizedBox(height: 10),
                settingItem(() {
                  Navigator.of(context).push(createRoute(
                    screen: const EditProfile(),
                    begin: const Offset(1, 0),
                  ));
                }, Icons.person, "account".translate(context)),
                const SizedBox(height: 20),
                settingItem(
                  () {
                    Navigator.of(context).push(createRoute(
                      screen: const ChangePasswordPage(),
                      begin: const Offset(1, 0),
                    ));
                  },
                  Icons.lock_outline_rounded,
                  "change_password".translate(context),
                ),
                const SizedBox(height: 20),
                settingItem(
                  () async {
                    return showDialog(
                      context: context,
                      // barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return customAlertDialog(
                          context: context,
                          title: "delete_the_account".translate(context),
                          content: "do_you_want_to_delete_this_account"
                              .translate(context),
                          onOK: () => context
                              .read<SettingBloc>()
                              .add(DeleteUserEvent()),
                        );
                      },
                    );
                  },
                  Icons.delete,
                  "delete_the_account".translate(context),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget settingWidget() {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        int? lang = context.read<LanguageBloc>().language;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 5),
                child: Text(
                  "setting".translate(context),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        showMyBottomSheet(context);
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          const Icon(Icons.language,
                              color: Color(0xFFadadad), size: 30),
                          const SizedBox(width: 8),
                          Text(
                            "language".translate(context),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            lang == 0 ? "Tiếng Việt" : "English",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_ios_rounded),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget infoWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 5),
            child: Text(
              "information".translate(context),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                const SizedBox(height: 10),
                settingItem(
                  () {
                    Navigator.of(context).push(createRoute(
                      screen: const PolicyPage(),
                      begin: const Offset(1, 0),
                    ));
                  },
                  Icons.security_rounded,
                  "policy".translate(context),
                ),
                const SizedBox(height: 20),
                settingItem(
                  () {
                    Navigator.of(context).push(createRoute(
                      screen: const InfoPage(),
                      begin: const Offset(1, 0),
                    ));
                  },
                  Icons.info_outline_rounded,
                  "application_information".translate(context),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget settingItem(VoidCallback onTap, IconData icon, String text) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, color: const Color(0xFFadadad), size: 30),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  void showMyBottomSheet(BuildContext context) {
    bool isVN = language == 0;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  titleBottomSheet(
                    "language_selection".translate(context),
                    () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: languageWidget(
                          image: AppImages.imgVietNam,
                          text: "Tiếng Việt",
                          onPress: () => setState(() => isVN = true),
                          isPick: isVN,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: languageWidget(
                          image: AppImages.imgEnglish,
                          text: "English",
                          onPress: () => setState(() => isVN = false),
                          isPick: !isVN,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: customButton(
                      text: 'ok'.translate(context),
                      onPress: () => changeLanguage(context, isVN ? 0 : 1),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future changeLanguage(BuildContext context, int lang) async {
    if (lang != language) {
      BlocProvider.of<LanguageBloc>(context)
          .add(ChangeLanguageEvent(lang == 0));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('language', lang);
      if (context.mounted) {
        language = lang;
        // context.read<SettingBloc>().add();
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Widget languageWidget({
    required String image,
    required String text,
    required VoidCallback onPress,
    required bool isPick,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isPick ? Colors.red : Colors.black54,
            width: isPick ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [Image.asset(image, height: 90), Text(text)],
        ),
      ),
    );
  }
}
