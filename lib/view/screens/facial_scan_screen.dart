import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:camera/camera.dart';
import 'package:vagrancy_beggars/controllers/getxController/facialscan_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme%20_controller.dart';

class FacialScanScreen extends StatefulWidget {
  const FacialScanScreen({super.key});

  @override
  State<FacialScanScreen> createState() => _FacialScanScreenState();
}

class _FacialScanScreenState extends State<FacialScanScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FacialScanController());
    final themeController = Get.find<ThemeController>();
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(() {
        final isDark = themeController.isDark.value;
        final bgColor = Theme.of(context).scaffoldBackgroundColor;
        final textColor = Theme.of(context).textTheme.bodyMedium!.color;

        if (!controller.isCameraInitialized.value) {
          return Center(
            child: CircularProgressIndicator(
              color: isDark ? Colors.white : Colors.blueAccent,
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: mediaQuery.height * 0.1),

              // Top Row with back button and title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: isDark ? Colors.white : Colors.blueAccent,
                    ),
                  ),
                  SizedBox(width: mediaQuery.width * 0.2),
                  Text(
                    'Facial Scan',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.blueAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: mediaQuery.height * 0.1),

              // Camera preview container
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                height: 320,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade800
                      : const Color(0xFF0B1124),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CameraPreview(controller.cameraController!),
                    ),
                    CustomPaint(
                      size: const Size(double.infinity, double.infinity),
                      painter: _FaceFramePainter(isDark: isDark),
                    ),
                  ],
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.1),

              Text(
                'Slide to Begin Scan',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.blueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: mediaQuery.height * 0.02),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SlideAction(
                  borderRadius: 30,
                  elevation: 0,
                  innerColor: Colors.red,
                  outerColor: isDark
                      ? Colors.grey.shade800
                      : Colors.grey.shade200,
                  sliderButtonIcon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  text: "  >>>>>>>>>>>>>>>>>",
                  textStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onSubmit: () => controller.startFaceScan(context),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _FaceFramePainter extends CustomPainter {
  final bool isDark;
  _FaceFramePainter({this.isDark = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double corner = 20;
    const double inset = 30;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - 2 * inset,
      size.height - 2 * inset,
    );

    // Draw corner brackets
    canvas.drawLine(rect.topLeft, Offset(rect.left + corner, rect.top), paint);
    canvas.drawLine(rect.topLeft, Offset(rect.left, rect.top + corner), paint);
    canvas.drawLine(
      rect.topRight,
      Offset(rect.right - corner, rect.top),
      paint,
    );
    canvas.drawLine(
      rect.topRight,
      Offset(rect.right, rect.top + corner),
      paint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      Offset(rect.left + corner, rect.bottom),
      paint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      Offset(rect.left, rect.bottom - corner),
      paint,
    );
    canvas.drawLine(
      rect.bottomRight,
      Offset(rect.right - corner, rect.bottom),
      paint,
    );
    canvas.drawLine(
      rect.bottomRight,
      Offset(rect.right, rect.bottom - corner),
      paint,
    );

    // Draw dotted face outline
    final faceOutline = Path()
      ..addOval(
        Rect.fromCenter(
          center: size.center(Offset.zero),
          width: size.width / 2,
          height: size.height / 1.5,
        ),
      );

    double dashWidth = 6, dashSpace = 4, distance = 0.0;
    for (var metric in faceOutline.computeMetrics()) {
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
