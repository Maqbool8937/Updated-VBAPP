import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BeggarController extends GetxController {
  // Profile Fields
  var name = ''.obs;
  var cnic = ''.obs;
  var age = ''.obs;
  var faith = ''.obs;

  // Images
  var faceImage = Rx<File?>(null);
  var fingerprintImage = Rx<File?>(null);

  // Type of Beggar
  var selectedBeggarType = ''.obs;

  // Previous Record
  var hasPreviousRecord = false.obs;
  var previousRecordText = ''.obs;

  // Addiction / Disability / Issues
  var selectedIssue = ''.obs;

  // Additional Data
  var address = ''.obs;
  var notes = ''.obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickFaceImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      faceImage.value = File(picked.path);
    }
  }

  Future<void> pickFingerprintImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      fingerprintImage.value = File(picked.path);
    }
  }

  bool validateForm() {
    if (name.isEmpty ||
        cnic.isEmpty ||
        age.isEmpty ||
        faith.isEmpty ||
        selectedBeggarType.isEmpty ||
        selectedIssue.isEmpty) {
      return false;
    }
    return true;
  }

  void submitForm() {
    if (!validateForm()) {
      Get.snackbar("Error", "Please complete all required fields");
      return;
    }

    // TODO: Send data to API
    print("Form Submitted Successfully");
    Get.snackbar("Success", "Beggar record saved");
  }
}
