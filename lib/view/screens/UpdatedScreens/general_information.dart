import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/generalinformation_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/langauage_dropdown_controller.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/person_intercepted.dart';
import 'package:vagrancy_beggars/view/widgets/costom_text_field.dart';
import 'package:vagrancy_beggars/view/widgets/language_dropdown.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({super.key});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  final GeneralInformationController controller = Get.put(
    GeneralInformationController(),
  );
  final LanguagePickerController dropcostcontroller = Get.put(
    LanguagePickerController(),
  );

  // Text controllers
  final TextEditingController ctpController = TextEditingController();
  final TextEditingController distController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  // Reactive error messages
  final RxString ctpError = "".obs;
  final RxString distError = "".obs;
  final RxString placeError = "".obs;

  // Progress percentage
  final double progress = 0.3; // 30% for first screen

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
          'General Information',
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
              // ===== Top Progress Slider with Percentage =====
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
              SizedBox(height: mediaQuery.height * 0.02),

              // Date & Time
              const Text(
                'Date & Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              CustomTextField(
                controller: controller.dateController,
                hintText: "Select Date & Time",
                prefixIcon: Icons.calendar_today,
                readOnly: true,
                onTap: () => controller.pickDateTime(context),
              ),
              SizedBox(height: mediaQuery.height * 0.02),

              // Location
              const Text(
                'Location (Auto)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              Obx(() {
                return CustomTextField(
                  controller: controller.locationController,
                  hintText: controller.isLoadingLocation.value
                      ? "Fetching location..."
                      : "Location unavailable",
                  readOnly: true,
                  prefixIcon: Icons.location_on,
                  onTap: () => controller.getCurrentLocation(),
                );
              }),
              SizedBox(height: mediaQuery.height * 0.02),

              // Department
              const Text(
                'Department',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              Obx(
                () => CustomTextField(
                  controller: ctpController,
                  hintText: "CTP",
                  errorText: ctpError.value.isEmpty ? null : ctpError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.02),

              // District
              const Text(
                'District',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              Obx(
                () => CustomTextField(
                  controller: distController,
                  hintText: "Lahore",
                  errorText: distError.value.isEmpty ? null : distError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.02),

              // Police Station
              const Text(
                'Police Station',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              CustomDropDown(),
              SizedBox(height: mediaQuery.height * 0.02),

              // Place
              const Text(
                'Place',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mediaQuery.height * 0.01),
              Obx(
                () => CustomTextField(
                  controller: placeController,
                  hintText: "Enter place where intercepted",
                  errorText: placeError.value.isEmpty ? null : placeError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.04),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.height * 0.018,
                    ),
                  ),
                  onPressed: () {
                    // Reset errors
                    ctpError.value = "";
                    distError.value = "";
                    placeError.value = "";

                    bool isValid = true;
                    if (ctpController.text.trim().isEmpty) {
                      ctpError.value = "CTP is required";
                      isValid = false;
                    }
                    if (distController.text.trim().isEmpty) {
                      distError.value = "District is required";
                      isValid = false;
                    }
                    if (placeController.text.trim().isEmpty) {
                      placeError.value = "Place is required";
                      isValid = false;
                    }

                    if (isValid) {
                      Get.snackbar(
                        "Success",
                        "All required fields are valid",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      Get.to(() => PersonIntercepted());
                    }
                  },
                  child: Text(
                    "Continue",
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
}
