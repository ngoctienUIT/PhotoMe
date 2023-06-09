import 'package:flutter/material.dart';
import 'package:photo_me/src/presentation/notification/screen/notification_page.dart';
import 'package:photo_me/src/presentation/profile/screen/profile_page.dart';
import 'package:photo_me/src/presentation/search/screen/search_page.dart';

import '../../../core/function/on_will_pop.dart';
import '../../home/screen/home_page.dart';
import '../widgets/bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  DateTime? currentBackPressTime;
  final PageStorageBucket bucket = PageStorageBucket();
  final PageController _pageController = PageController();
  List<Widget> screens = [
    const HomePage(key: PageStorageKey<String>('HomePage')),
    const SearchPage(key: PageStorageKey<String>('SearchPage')),
    const NotificationPage(key: PageStorageKey<String>('NotificationPage')),
    const ProfilePage(key: PageStorageKey<String>('ProfilePage')),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          onPageChanged: (value) => setState(() => currentTab = value),
          itemBuilder: (context, index) {
            return PageStorage(bucket: bucket, child: screens[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomBar(
        currentTab: currentTab,
        onTab: (int value) {
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          setState(() => currentTab = value);
        },
      ),
    );
  }
}
