import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/bottom_nav_controller.dart';
import 'package:vagrancy_beggars/view/screens/nav_bar_screen/calendar_screen.dart';
import 'package:vagrancy_beggars/view/screens/nav_bar_screen/message_screen.dart';
import 'package:vagrancy_beggars/view/screens/nav_bar_screen/search_screen.dart';
import 'package:vagrancy_beggars/view/screens/settings_logout.dart';
import 'home_screen.dart';

class MainNavScreen extends StatelessWidget {
  MainNavScreen({super.key});

  final BottomNavController navController = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeScreen(),
    MessageScreen(),
    SearchScreen(),
    CalendarScreen(),

    SettingsLogout(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages[navController.currentIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: navController.currentIndex.value,
          onTap: navController.changeIndex,
          selectedItemColor: Color(0xffED1C24),
          unselectedItemColor: Color(0xff6B7280),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: "Messages",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
