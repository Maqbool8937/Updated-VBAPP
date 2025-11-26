import 'package:get/get.dart';

class BaggeryController extends GetxController {
  final selectedLanguage = "Select Type".obs;

  final List<String> languages = [
    "Child",
    "Women",
    "Disabled",
    "Organized Gang",
    "Individual",
  ];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
