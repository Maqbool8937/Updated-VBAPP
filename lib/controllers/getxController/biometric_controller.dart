import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;

class BiometricController extends GetxController {
  CameraController? cameraController;

  final faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  var isCameraInitialized = false.obs;
  var isScanningFace = false.obs;
  var isFaceDetected = false.obs;
  var capturedFaceImage = Rxn<File>();
  var isThumbScanned = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  /// Initialize back camera
  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("No cameras found");
        return;
      }
      final backCamera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      cameraController = CameraController(backCamera, ResolutionPreset.medium);
      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      print("Camera init error: $e");
      isCameraInitialized.value = false;
    }
  }

  /// Capture face image and show on screen (do not upload yet)
  Future<void> captureFace() async {
    if (!isCameraInitialized.value || isScanningFace.value) return;

    isScanningFace.value = true;
    isFaceDetected.value = false;

    try {
      final picture = await cameraController!.takePicture();
      final inputImage = InputImage.fromFilePath(picture.path);
      final faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        isFaceDetected.value = true;
        capturedFaceImage.value = File(picture.path);
        Get.snackbar("Success", "Face captured! Click Continue to upload.");
      } else {
        Get.snackbar("Failed", "No face detected. Try again.");
      }
    } catch (e) {
      print("Face capture error: $e");
      Get.snackbar("Error", "Face capture failed! ${e.toString()}");
    }

    isScanningFace.value = false;
  }

  /// Upload captured face image to backend
  Future<void> uploadCapturedFace() async {
    final file = capturedFaceImage.value;
    if (file == null) {
      Get.snackbar("Error", "No face image to upload.");
      return;
    }

    try {
      final url = Uri.parse("https://your-api.com/upload-biometrics");
      var request = http.MultipartRequest("POST", url)
        ..files.add(await http.MultipartFile.fromPath("face_image", file.path))
        ..fields["user_id"] = "123";

      final response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Face image uploaded successfully!");
        capturedFaceImage.value = null;
      } else {
        Get.snackbar("Error", "Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Upload error: $e");
      Get.snackbar("Error", "Upload failed! ${e.toString()}");
    }
  }

  /// Fingerprint / thumb scan
  Future<void> scanThumb() async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isSupported) {
        Get.snackbar(
          "Error",
          "Device does not support fingerprint/biometric authentication",
        );
        return;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to verify identity',
        biometricOnly: true,
      );

      if (authenticated) {
        isThumbScanned.value = true;
        Get.snackbar("Success", "Fingerprint authenticated!");
      } else {
        Get.snackbar("Failed", "Fingerprint authentication failed!");
      }
    } catch (e) {
      print("Thumb scan error: $e");
      Get.snackbar("Error", "Thumb scan failed! ${e.toString()}");
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    faceDetector.close();
    super.onClose();
  }
}






// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:camera/camera.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:http/http.dart' as http;

// class BiometricController extends GetxController {
//   CameraController? cameraController;

//   final faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableContours: true,
//       enableLandmarks: true,
//       performanceMode: FaceDetectorMode.fast,
//     ),
//   );

//   var isCameraInitialized = false.obs;
//   var isScanningFace = false.obs;
//   var isFaceDetected = false.obs;
//   var isThumbScanned = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeCamera();
//   }

//   /// Initialize back camera
//   Future<void> initializeCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final backCamera = cameras.firstWhere(
//         (cam) => cam.lensDirection == CameraLensDirection.back,
//       );
//       cameraController = CameraController(backCamera, ResolutionPreset.medium);
//       await cameraController!.initialize();
//       isCameraInitialized.value = true;
//     } catch (e) {
//       print("Camera init error: $e");
//       isCameraInitialized.value = false;
//     }
//   }

//   /// Capture face and upload
//   Future<void> startFaceScan() async {
//     if (!isCameraInitialized.value || isScanningFace.value) return;

//     isScanningFace.value = true;
//     isFaceDetected.value = false;

//     try {
//       final picture = await cameraController!.takePicture();
//       final inputImage = InputImage.fromFilePath(picture.path);
//       final faces = await faceDetector.processImage(inputImage);

//       if (faces.isNotEmpty) {
//         isFaceDetected.value = true;
//         await uploadToApi(File(picture.path), "face_image");
//         Get.snackbar("Success", "Face captured & uploaded!");
//       } else {
//         Get.snackbar("Failed", "No face detected. Try again.");
//       }
//     } catch (e) {
//       print("Face scan error: $e");
//       Get.snackbar("Error", "Face scan failed! ${e.toString()}");
//     }

//     isScanningFace.value = false;
//   }





//   /// Fingerprint / thumb scan (for local_auth 3.0.0)

//   Future<void> scanThumb() async {
//     final LocalAuthentication auth = LocalAuthentication();

//     try {
//       bool canCheckBiometrics = await auth.canCheckBiometrics;
//       bool isSupported = await auth.isDeviceSupported();

//       if (!canCheckBiometrics || !isSupported) {
//         Get.snackbar(
//           "Error",
//           "Device does not support fingerprint/biometric authentication",
//         );
//         return;
//       }

//       // Authenticate using 3.0.0 API
//       bool authenticated = await auth.authenticate(
//         localizedReason: 'Scan your fingerprint to verify identity',
//         biometricOnly: true, // optional, only use biometrics
//       );

//       if (authenticated) {
//         isThumbScanned.value = true;
//         Get.snackbar("Success", "Fingerprint authenticated!");
//       } else {
//         Get.snackbar("Failed", "Fingerprint authentication failed!");
//       }
//     } catch (e) {
//       print("Thumb scan error: $e");
//       Get.snackbar("Error", "Thumb scan failed! ${e.toString()}");
//     }
//   }

//   /// Upload file to backend API
//   Future<void> uploadToApi(File file, String fieldName) async {
//     try {
//       final url = Uri.parse("https://your-api.com/upload-biometrics");
//       var request = http.MultipartRequest("POST", url)
//         ..files.add(await http.MultipartFile.fromPath(fieldName, file.path))
//         ..fields["user_id"] = "123"; // Replace with actual user ID

//       final response = await request.send();
//       if (response.statusCode == 200) {
//         print("$fieldName uploaded successfully");
//       } else {
//         print("Upload failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("API Upload Error: $e");
//     }
//   }

//   @override
//   void onClose() {
//     cameraController?.dispose();
//     faceDetector.close();
//     super.onClose();
//   }
// }






















