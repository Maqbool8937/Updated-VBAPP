import 'package:get/get.dart';

class Linked2Controller extends GetxController {
  final selectedLanguage = "Select Linked".obs;

  final List<String> languages = [
    "Lahore Street Gangs",
    "Traffic Extortion Groups",
    "Drug Distribution Networks",
    "Market Protection Rackets",
    "Neighborhood Criminal Syndicates",
  ];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
