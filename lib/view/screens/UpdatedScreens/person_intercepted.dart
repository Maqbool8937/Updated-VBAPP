import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vagrancy_beggars/controllers/getxController/person_intercepted_controller.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/personal_data.dart';

class PersonIntercepted extends StatelessWidget {
  PersonIntercepted({super.key});

  final PersonInterceptedController controller = Get.put(
    PersonInterceptedController(),
  );

  final LocalAuthentication auth = LocalAuthentication();
  final ImagePicker _picker = ImagePicker();

  // Progress percentage for this second screen
  final double progress = 0.5; // 50%

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        title: const Text(
          'Person Intercepted',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.04,
            vertical: mediaQuery.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Top Progress Slider =====
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: mediaQuery.height * 0.01,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: mediaQuery.width * 0.02),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width * 0.035,
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaQuery.height * 0.03),

              // ===== Face Photo =====
              const Text(
                'Photo (Face)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              Obx(() => _imagePreview(controller.faceImage.value, mediaQuery)),
              SizedBox(height: mediaQuery.height * 0.015),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.pickFaceFromGallery,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(
                          double.infinity,
                          mediaQuery.height * 0.065,
                        ),
                      ),
                      child: const Text('Upload'),
                    ),
                  ),
                  SizedBox(width: mediaQuery.width * 0.03),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.pickFaceFromCamera,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(
                          double.infinity,
                          mediaQuery.height * 0.065,
                        ),
                      ),
                      child: const Text('Camera'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaQuery.height * 0.03),

              // ===== Fingerprint =====
              const Text(
                'Biometric (Fingerprint)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              Obx(
                () => Container(
                  height: mediaQuery.height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                    image: controller.fingerprintImage.value != null
                        ? DecorationImage(
                            image: FileImage(
                              controller.fingerprintImage.value!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Center(
                    child: controller.fingerprintVerified.value
                        ? (controller.fingerprintImage.value == null
                              ? Text(
                                  'Fingerprint Verified\nTake Picture',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: mediaQuery.width * 0.04,
                                  ),
                                )
                              : null)
                        : Icon(
                            Icons.fingerprint,
                            color: Colors.grey,
                            size: mediaQuery.width * 0.15,
                          ),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.015),

              ElevatedButton.icon(
                onPressed: () async => await _scanFingerprintAndCapture(),
                icon: const Icon(Icons.fingerprint),
                label: const Text('Scan Fingerprint & Capture'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, mediaQuery.height * 0.065),
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.03),

              // ===== Submit Button =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.faceImage.value == null) {
                      Get.snackbar(
                        'Error',
                        'Please upload face photo',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    if (controller.fingerprintImage.value == null ||
                        !controller.fingerprintVerified.value) {
                      Get.snackbar(
                        'Error',
                        'Please scan fingerprint and capture photo',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // TODO: Send data to backend
                    Get.snackbar(
                      'Success',
                      'Data submitted successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                    Get.to(() => PersonalData());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.height * 0.018,
                    ),
                  ),
                  child: Text(
                    'Submit Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: mediaQuery.width * 0.045,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePreview(File? image, Size mediaQuery) {
    return Container(
      height: mediaQuery.height * 0.18,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
        image: image != null
            ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? const Center(
              child: Text(
                'No Image Selected',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : null,
    );
  }

  Future<void> _scanFingerprintAndCapture() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to verify',
      );

      controller.fingerprintVerified.value = authenticated;

      if (authenticated) {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
        );
        if (image != null) {
          controller.fingerprintImage.value = File(image.path);

          Get.snackbar(
            'Success',
            'Fingerprint verified and picture captured',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Failed',
          'Fingerprint verification failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Biometric scan not available on this device',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}
