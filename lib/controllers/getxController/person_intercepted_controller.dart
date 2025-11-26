import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class PersonInterceptedController extends GetxController {
  var faceImage = Rxn<File>();
  var fingerprintVerified = false.obs;
  var fingerprintImage = Rxn<File>(); // <-- store fingerprint picture

  final ImagePicker _picker = ImagePicker();
  final LocalAuthentication auth = LocalAuthentication();

  // ===== Face Image Functions =====
  Future<void> pickFaceFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) faceImage.value = File(image.path);
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> pickFaceFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) faceImage.value = File(image.path);
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture image: $e');
    }
  }

  // ===== Fingerprint Authentication + Picture =====
  Future<void> scanFingerprintAndTakePicture() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      if (!canCheck) {
        Get.snackbar(
          'Error',
          'Device does not support fingerprint authentication',
        );
        return;
      }

      // Step 1: Authenticate fingerprint
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to verify identity',
        biometricOnly: true,
      );

      fingerprintVerified.value = authenticated;

      if (!authenticated) {
        Get.snackbar(
          'Failed',
          'Fingerprint verification failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Get.snackbar(
        'Success',
        'Fingerprint verified successfully! Now take a picture of your finger.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Step 2: Take fingerprint picture
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        fingerprintImage.value = File(image.path);
        Get.snackbar(
          'Success',
          'Fingerprint picture captured!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Fingerprint authentication error: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
