import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:intl/intl.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/view/screens/match_found_screen.dart';

class FacialScanController extends GetxController {
  CameraController? cameraController;
  final faceDetector = FaceDetector(
    options: FaceDetectorOptions(enableContours: true, enableLandmarks: true),
  );

  var isCameraInitialized = false.obs;
  var isDetecting = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
    );
    cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }

  Future<void> startFaceScan(BuildContext context) async {
    if (cameraController == null || isDetecting.value) return;

    isDetecting.value = true;

    final image = await cameraController!.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      _showSuccessBottomSheet(context);
    } else {
      final themeController = Get.find<ThemeController>();
      final isDark = themeController.isDark.value;

      Get.snackbar(
        "No Face Detected",
        "Please try again.",
        backgroundColor: isDark ? Colors.red.shade700 : Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }

    isDetecting.value = false;
  }

  void _showSuccessBottomSheet(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);
    final formattedTime = DateFormat('hh:mm a').format(now);

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_rounded, color: Colors.green, size: 70),
            const SizedBox(height: 16),
            Text(
              "Face Scan Successful!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "$formattedDate\n$formattedTime",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Get.back(); // Close bottom sheet
                  Get.to(() => MatchFoundScreen());
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    cameraController?.dispose();
    faceDetector.close();
    super.onClose();
  }
}
