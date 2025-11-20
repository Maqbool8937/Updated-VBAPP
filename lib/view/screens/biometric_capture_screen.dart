import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vagrancy_beggars/controllers/getxController/biometric_controller.dart';
import 'package:vagrancy_beggars/view/screens/personal_information_screen.dart';

class BiometricCaptureScreen extends StatelessWidget {
  const BiometricCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BiometricController());

    final bg = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              /// ----------------- Step Header -----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Step 1 of 4",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  Text(
                    "20%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// ----------------- Progress Bar -----------------
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.2,
                  backgroundColor: isDark ? Colors.white12 : Colors.grey[300],
                  color: Colors.redAccent,
                  minHeight: 6,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Biometric Capture",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                "We need to capture your biometric data for secure identification.",
                style: TextStyle(
                  color: textColor!.withOpacity(0.6),
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 20),

              /// ----------------- Face Detection Card -----------------
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white10
                                : Colors.black.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomPaint(painter: _FaceOutlinePainter()),
                        ),

                        if (controller.isScanningFace.value)
                          Lottie.asset(
                            'assets/scan_animation.json',
                            width: 120,
                            repeat: true,
                          ),

                        if (controller.isFaceDetected.value)
                          const Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 60,
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Face Detection",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Text(
                          controller.isScanningFace.value
                              ? "🔴 Scanning..."
                              : controller.isFaceDetected.value
                              ? "✅ Success"
                              : "Idle",
                          style: TextStyle(
                            color: controller.isFaceDetected.value
                                ? Colors.green
                                : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Position your face within the outline and look directly at the camera.",
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: controller.startFaceScan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Start Face Scan"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ----------------- Thumb Scanner -----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: controller.scanThumb,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: controller.isThumbScanned.value
                            ? const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 50,
                              )
                            : Column(
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.grey,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Tap to scan your thumb",
                                    style: TextStyle(
                                      color: textColor.withOpacity(0.6),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Place your thumb on the scanner when prompted.",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              /// ----------------- Info Box -----------------
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: textColor.withOpacity(0.6),
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Your biometric data is securely encrypted and will only be used for authentication purposes.",
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ----------------- Continue Button -----------------
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => PersonalInformationScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF140D44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Continue ➜",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    canvas.drawCircle(center, radius, paint);
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
