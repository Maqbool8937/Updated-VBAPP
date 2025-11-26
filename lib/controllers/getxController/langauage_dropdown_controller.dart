import 'package:get/get.dart';

class LanguagePickerController extends GetxController {
  final selectedLanguage = "Select Police Station".obs;

  final List<String> languages = [
    "Anarkali Police Station",
    "Dharampura Police Station",
    "Ferozepur Road Police Station",
    "Gulberg Police Station",
    "Data Gunj Bakhsh Police Station",
    "Shadman Police Station",
    "Model Town Police Station",
    "Samanabad Police Station",
    "Johar Town Police Station",
    "Wapda Town Police Station",
    "Ravi Police Station",
    "Yadgar-e-Shah Police Station",
    "Sabzazar Police Station",
    "Lahore Cantt Police Station",
    "Shalimar Police Station",
  ];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
