import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme%20_controller.dart';

import 'package:vagrancy_beggars/view/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController()); // register controller

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Punjab Beggars & Vagrancy Portal',
        debugShowCheckedModeBanner: false,
        themeMode: themeController.theme,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: SplashScreen(),
      ),
    );
  }
}
