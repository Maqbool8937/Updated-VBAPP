import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vagrancy_beggars/view/screens/photo_location_screen.dart';

class PersonalInfoController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final clothingController = TextEditingController();
  final notesController = TextEditingController();

  var gender = 'male'.obs;

  String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Age is optional
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Please enter a valid number';
    }
    if (age < 0 || age > 150) {
      return 'Please enter a valid age (0-150)';
    }
    return null;
  }

  bool validateForm() {
    // Age validation (optional field)
    final ageError = validateAge(ageController.text);
    if (ageError != null) {
      Get.snackbar(
        'Validation Error',
        ageError,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  // Example function to handle Continue
  void onContinue() {
    if (!validateForm()) {
      return;
    }

    // Store validated data
    print('Name: ${nameController.text}');
    print('Gender: ${gender.value}');
    print('Age: ${ageController.text}');
    print('Clothing: ${clothingController.text}');
    print('Notes: ${notesController.text}');

    // Navigate to next screen (Step 3)
    Get.to(() => PhotoLocationScreen());
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    clothingController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
