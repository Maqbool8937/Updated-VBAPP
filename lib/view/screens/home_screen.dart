import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/mapcontroller.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/bottom_nav_controller.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/addbaggersdata_screen.dart';
import 'package:vagrancy_beggars/view/screens/assigned_cases_screen.dart';
import 'package:vagrancy_beggars/view/screens/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final themeController = Get.find<ThemeController>();
    final mapController = Get.put(MapController());

    return Scaffold(
      body: Obx(() {
        final isDark = themeController.isDark.value;

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.height * 0.05),

              // TOP HEADER
              Container(
                height: mediaQuery.height * 0.1,
                width: mediaQuery.width,
                color: isDark ? Colors.grey.shade900 : const Color(0xff140D44),
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.1),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.03,
                  vertical: mediaQuery.height * 0.02,
                ),
                child: Column(
                  children: [
                    // QUICK ACCESS ROW 1
                    _buildQuickAccessRow(
                      mediaQuery,
                      ['Records', 'Alerts'],
                      isDark,
                      [() => Get.to(() => const AssignedCasesScreen())],
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),

                    // QUICK ACCESS ROW 2
                    _buildQuickAccessRow(
                      mediaQuery,
                      ['Map', 'Settings'],
                      isDark,
                      [
                        () => Get.to(() => MapScreen()),
                        () {
                          final navController = Get.find<BottomNavController>();
                          navController.changeIndex(4); // Settings tab
                        },
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.15),

              // SAVE RECORD BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => AddbaggersdataScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // button color
                      side: BorderSide.none, // remove border
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Add New Record',
                      style: TextStyle(
                        color: Colors.white, // text color
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.05),
            ],
          ),
        );
      }),
    );
  }
}

// QUICK ACCESS ROW WIDGET
Widget _buildQuickAccessRow(
  Size mediaQuery,
  List<String> items,
  bool isDark,
  List<VoidCallback> onTapCallbacks,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      IconData icon;
      switch (item) {
        case 'Reports':
          icon = Icons.file_copy;
          break;
        case 'Alerts':
          icon = Icons.alarm_rounded;
          break;
        case 'Map':
          icon = Icons.map;
          break;
        case 'Settings':
          icon = Icons.settings;
          break;
        default:
          icon = Icons.help;
      }

      return GestureDetector(
        onTap: index < onTapCallbacks.length ? onTapCallbacks[index] : null,
        child: Container(
          height: mediaQuery.height * 0.15,
          width: mediaQuery.width * 0.4,
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.07),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.red),
              SizedBox(height: mediaQuery.height * 0.015),
              Text(
                item,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}
