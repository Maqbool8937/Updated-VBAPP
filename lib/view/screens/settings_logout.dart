import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme%20_controller.dart';
import 'package:vagrancy_beggars/services/auth_service.dart';
import 'package:vagrancy_beggars/view/screens/change_password_screen.dart';
import 'package:vagrancy_beggars/view/screens/langauage_screen.dart';
import 'package:vagrancy_beggars/view/screens/welcome_back_screen.dart';

class SettingsLogout extends StatelessWidget {
  const SettingsLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final size = MediaQuery.of(context).size;

    final isDark = themeController.isDark.value;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;

    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              // TOP BANNER
              Container(
                width: size.width,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade900
                      : const Color(0xff1F2937),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Dr. Usman Anwar (IG Police)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'ID: 56745',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // SETTINGS CARD
              Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: cardColor,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.lock, color: Colors.blueAccent),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(() => ChangePasswordScreen()),
                    ),

                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.language,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        'language'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => Get.to(() => LanguageScreen()),
                    ),

                    const Divider(),

                    // DARK MODE TOGGLE
                    ListTile(
                      leading: const Icon(
                        Icons.nightlight_outlined,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Switch(
                        value: themeController.isDark.value,
                        onChanged: (value) {
                          themeController.toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // LOGOUT CARD
              Container(
                height: size.height * 0.09,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: cardColor,
                ),
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () async {
                      // Show confirmation dialog
                      final shouldLogout = await Get.dialog<bool>(
                        AlertDialog(
                          title: const Text('Logout'),
                          content: const Text(
                            'Are you sure you want to logout?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(result: false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Get.back(result: true),
                              child: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        try {
                          final authService = AuthService();
                          await authService.logout();
                          Get.offAll(() => WelcomeBackScreen());
                          Get.snackbar(
                            'Success',
                            'Logged out successfully',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to logout: $e',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
