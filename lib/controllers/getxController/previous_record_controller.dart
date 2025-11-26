import 'package:get/get.dart';

class PreRecController extends GetxController {
  final selectedLanguage = "Select Type".obs;

  final List<String> languages = ["Repeater", "Fresh"];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
