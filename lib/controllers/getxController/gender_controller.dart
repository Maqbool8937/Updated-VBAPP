import 'package:get/get.dart';

class GenderController extends GetxController {
  final selectedLanguage = "Select Gender".obs;

  final List<String> languages = ["Male", "Female", "Other"];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
