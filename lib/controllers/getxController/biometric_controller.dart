
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class BiometricController extends GetxController {
  CameraController? cameraController;
  final faceDetector = FaceDetector(
    options: FaceDetectorOptions(enableContours: true, enableLandmarks: true),
  );

  var isCameraInitialized = false.obs;
  var isScanningFace = false.obs;
  var isFaceDetected = false.obs;
  var isThumbScanned = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.back,
    );
    cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }

  Future<void> startFaceScan() async {
    if (isScanningFace.value) return;

    isScanningFace.value = true;
    isFaceDetected.value = false;

    final image = await cameraController!.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      isFaceDetected.value = true;
    }

    isScanningFace.value = false;
  }

  void scanThumb() async {
    // Simulate thumb scan
    isThumbScanned.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isThumbScanned.value = false;
    Get.snackbar(
      "Success",
      "Thumbprint Captured Successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    cameraController?.dispose();
    faceDetector.close();
    super.onClose();
  }
}
