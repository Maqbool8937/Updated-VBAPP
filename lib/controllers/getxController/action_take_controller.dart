import 'package:get/get.dart';

class ActionTakController extends GetxController {
  final selectedLanguage = "Select action type".obs;

  // FIR fields visibility
  var showFIRFields = false.obs;

  // Organization field visibility
  var showOrganizationField = false.obs;

  // FIR input values
  var firNumber = "".obs;
  var policeStation = "".obs;

  // Organization name
  var organizationName = "".obs;

  final List<String> languages = [
    "FIR",
    "Taken to Edhi/NGO",
    "Child Protection Bureau",
    "Beggars Home/ Social Welfare",
  ];

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;

    // FIR selection
    if (lang == "FIR") {
      showFIRFields.value = true;
      showOrganizationField.value = false;
    }
    // NGO selection
    else if (lang == "Taken to Edhi/NGO") {
      showFIRFields.value = false;
      showOrganizationField.value = true;
    }
    // Other options
    else {
      showFIRFields.value = false;
      showOrganizationField.value = false;
    }
  }
}

// import 'package:get/get.dart';

// class ActionTakController extends GetxController {
//   final selectedLanguage = "Select action type".obs;

//   // FIR fields visibility
//   var showFIRFields = false.obs;

//   // FIR input values
//   var firNumber = "".obs;
//   var policeStation = "".obs;

//   final List<String> languages = [
//     "FIR",
//     "Taken to Edhi/NGO",
//     "Child Protection Bureau",
//     "Beggars Home/ Social Welfare",
//   ];

//   void changeLanguage(String lang) {
//     selectedLanguage.value = lang;

//     if (lang == "FIR") {
//       showFIRFields.value = true;
//     } else {
//       showFIRFields.value = false;
//       firNumber.value = "";
//       policeStation.value = "";
//     }
//   }
// }
