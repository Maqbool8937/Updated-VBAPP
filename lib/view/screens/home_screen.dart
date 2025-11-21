import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/bottom_nav_controller.dart';
import 'package:vagrancy_beggars/view/screens/biometric_capture_screen.dart';
import 'package:vagrancy_beggars/view/screens/facial_scan_screen.dart';
import 'package:vagrancy_beggars/view/screens/assigned_cases_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Obx(() {
        final isDark = themeController.isDark.value;

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.height * 0.06),

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

              SizedBox(height: mediaQuery.height * 0.03),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.03,
                  vertical: mediaQuery.height * 0.02,
                ),
                child: Column(
                  children: [
                    // QUICK ACCESS ROW 1
                    _buildQuickAccessRow(mediaQuery, [
                      'Reports',
                      'Alerts',
                    ], isDark, [
                      () => Get.snackbar(
                        'Reports',
                        'Reports feature coming soon',
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      ),
                      () => Get.snackbar(
                        'Alerts',
                        'Alerts feature coming soon',
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      ),
                    ]),

                    SizedBox(height: mediaQuery.height * 0.02),

                    // QUICK ACCESS ROW 2
                    _buildQuickAccessRow(mediaQuery, [
                      'Map',
                      'Settings',
                    ], isDark, [
                      () => Get.snackbar(
                        'Map',
                        'Map view coming soon',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      ),
                      () {
                        final navController = Get.find<BottomNavController>();
                        navController.changeIndex(4); // Settings tab
                      },
                    ]),
                  ],
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.05),

              // ACTION BUTTONS
              _buildActionButton(
                mediaQuery,
                icon: Icons.qr_code_scanner,
                text: 'Scan Face',
                onTap: () => Get.to(() => const FacialScanScreen()),
                isDark: isDark,
              ),

              SizedBox(height: mediaQuery.height * 0.02),

              _buildActionButton(
                mediaQuery,
                icon: Icons.app_registration,
                text: 'Manual Registration',
                onTap: () => Get.to(() => const BiometricCaptureScreen()),
                isDark: isDark,
              ),

              SizedBox(height: mediaQuery.height * 0.02),

              _buildActionButton(
                mediaQuery,
                icon: Icons.cases_outlined,
                text: 'View Assigned Cases',
                onTap: () => Get.to(() => const AssignedCasesScreen()),
                isDark: isDark,
              ),

              SizedBox(height: mediaQuery.height * 0.05),
            ],
          ),
        );
      }),
    );
  }

  // ACTION BUTTON WIDGET
  Widget _buildActionButton(
    Size mediaQuery, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mediaQuery.height * 0.09,
        width: mediaQuery.width*0.9,
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.07),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, color: Colors.red),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
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
                Icon(icon, size: 20, color: Colors.red),
                SizedBox(height: mediaQuery.height * 0.02),
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 20,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
