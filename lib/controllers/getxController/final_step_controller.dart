import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/services/beggar_record_service.dart';
import 'package:vagrancy_beggars/controllers/getxController/biometric_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/personal_info_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/photo_location_controller.dart';
import 'package:vagrancy_beggars/view/screens/confirmation_screen.dart';

class FinalStepController extends GetxController {
  final notesController = TextEditingController();
  var selectedShelter = ''.obs;
  var isSubmitting = false.obs;

  final beggarRecordService = BeggarRecordService();

  final shelterList = [
    'Downtown Shelter',
    'Hope Center',
    'Safe Haven',
    'Community Care Shelter',
  ];

  Future<void> onCompleteRegistration() async {
    if (isSubmitting.value) return;

    try {
      isSubmitting.value = true;

      // Get data from other controllers
      final biometricController = Get.find<BiometricController>();
      final personalInfoController = Get.find<PersonalInfoController>();
      final photoLocationController = Get.find<PhotoLocationController>();

      // Get first photo as main photo (or use face image if available)
      File? photoFile;
      File? biometricFile;

      // Use first image as photo
      if (photoLocationController.images.isNotEmpty) {
        photoFile = photoLocationController.images.first;
      }

      // Use biometric image if available (from face scan or thumb)
      // For now, we'll use the face image if detected
      if (biometricController.isFaceDetected.value) {
        // In a real app, you'd save the captured face image to a file
        // For now, we'll use the first photo as biometric if no separate biometric
        if (photoLocationController.images.length > 1) {
          biometricFile = photoLocationController.images[1];
        }
      }

      // Get gender - map to API format
      String gender = personalInfoController.gender.value;
      if (gender.toLowerCase() == 'male') {
        gender = 'Male';
      } else if (gender.toLowerCase() == 'female') {
        gender = 'Female';
      } else {
        gender = 'Transgender';
      }

      // Get beggary type - default to Individual
      String beggaryType =
          'Individual'; // Can be: "Child", "Woman", "Disabled", "Organized Gang", "Individual"

      // Get age
      String? age = personalInfoController.ageController.text.trim();
      if (age.isEmpty) {
        age = null;
      }

      // Submit beggar record to backend
      await beggarRecordService.submitBeggarRecord(
        fullName: personalInfoController.nameController.text.trim().isEmpty
            ? 'Unknown'
            : personalInfoController.nameController.text.trim(),
        gender: gender,
        beggaryType: beggaryType,
        captureLocation: photoLocationController.address.value,
        policeStation: 'Unknown', // You may want to add this field to the form
        place: photoLocationController.address.value,
        age: age,
        additionalNotes: notesController.text.trim().isEmpty
            ? personalInfoController.notesController.text.trim()
            : '${notesController.text.trim()}\n${personalInfoController.notesController.text.trim()}',
        photo: photoFile,
        biometric: biometricFile,
      );

      isSubmitting.value = false;

      Get.snackbar(
        "Success",
        "Case registered successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate to confirmation screen
      Get.offAll(() => ConfirmationScreen());
    } catch (e) {
      isSubmitting.value = false;
      Get.snackbar(
        "Error",
        "Failed to submit case: ${e.toString().replaceAll('Exception: ', '')}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
