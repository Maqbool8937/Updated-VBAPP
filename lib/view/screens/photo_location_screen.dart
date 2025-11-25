import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vagrancy_beggars/controllers/getxController/photo_location_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/services/get_live_location.dart';

import '../../services/get_live_location.dart';

class PhotoLocationScreen extends StatelessWidget {
  const PhotoLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhotoLocationController());
    final themeController = Get.find<ThemeController>();
    final controllr = Get.put(PhotoLocationController());

    final isDark = themeController.isDark.value;
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final hintColor = Colors.grey;

    return Scaffold(
      backgroundColor: bg,
      body: Obx(
        () => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Step 3 of 4",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "80%",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.8,
                      backgroundColor: isDark
                          ? Colors.grey[800]
                          : Colors.grey[300],
                      color: Colors.redAccent,
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 25),

                  Text(
                    "Add Photos (Max 3)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Photo upload section
                  Row(
                    children: [
                      ...List.generate(controller.images.length, (index) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(controller.images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: GestureDetector(
                                onTap: () => controller.removeImage(index),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDark ? Colors.black : Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                      if (controller.images.length < 3)
                        GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark
                                    ? Colors.grey.shade600
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Add Photo",
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Upload clear photos of your property",
                    style: TextStyle(color: hintColor),
                  ),
                  const SizedBox(height: 25),

                  Text(
                    "Confirm Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Google Map
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      liteModeEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: controller.selectedLocation.value,
                        zoom: 14.5,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('selected'),
                          position: controller.selectedLocation.value,
                          draggable: true,
                          onDragEnd: controller.updateLocation,
                        ),
                      },
                      onTap: controller.updateLocation,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Address box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isDark ? Colors.grey.shade900 : Colors.grey[100],
                      border: Border.all(
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.address.value,
                            style: TextStyle(fontSize: 14, color: textColor),
                          ),
                        ),
                        // TextButton.icon(
                        //   onPressed: () {},
                        //   icon: const Icon(
                        //     Icons.edit,
                        //     size: 16,
                        //     color: Colors.blue,
                        //   ),
                        //   label: const Text(
                        //     "Edit",
                        //     style: TextStyle(color: Colors.blue),
                        //   ),
                        // ),
                        IconButton(
                          icon: Icon(Icons.edit_location_alt),
                          onPressed: () {
                            controller.getLiveLocation();
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "Drag the pin to adjust your exact location",
                    style: TextStyle(color: hintColor),
                  ),

                  const SizedBox(height: 40),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF140D44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: controller.onContinue,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
