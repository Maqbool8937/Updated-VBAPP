import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final box = GetStorage();

  var selectedLang = 'en_US'.obs;

  Locale get currentLocale {
    return selectedLang.value == 'ur_PK'
        ? Locale('ur', 'PK')
        : Locale('en', 'US');
  }

  @override
  void onInit() {
    selectedLang.value = box.read('selectedLang') ?? 'en_US';
    super.onInit();
  }

  void changeLanguage(String langCode) {
    selectedLang.value = langCode;

    if (langCode == 'ur_PK') {
      Get.updateLocale(Locale('ur', 'PK'));
    } else {
      Get.updateLocale(Locale('en', 'US'));
    }

    box.write('selectedLang', langCode);
  }
}
