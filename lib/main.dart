import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/controllers/utils/app_translations.dart';
import 'package:vagrancy_beggars/view/screens/splash_screen.dart';
import 'controllers/getxController/language_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init(); // 👈 Needed for saving language preference

  Get.put(ThemeController()); // Theme Controller
  Get.put(LanguageController()); // Language Controller

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Punjab Beggars & Vagrancy Portal',
        debugShowCheckedModeBanner: false,

        // 🔥 LOCALIZATION ENABLED
        translations: AppTranslations(),
        locale: langController.currentLocale, // 👈 Current language
        fallbackLocale: Locale('en', 'US'),

        // 🔥 THEME (unchanged)
        themeMode: themeController.theme,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),

        home: SplashScreen(),
        //home: BeggarFormScreen(),
      ),
    );
  }
}
