import 'package:get/get.dart';

class LinkedmafiaController extends GetxController {
  final selectedLanguage = "Select Options".obs;

  final List<String> languages = ["Male", "Female", "Other"];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
