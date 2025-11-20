import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/personal_info_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/view/screens/photo_location_screen.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInfoController());
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Obx(() {
        final isDark = themeController.isDark.value;

        final bg = Theme.of(context).scaffoldBackgroundColor;
        final textColor = Theme.of(context).textTheme.bodyMedium!.color;
        final cardColor = Theme.of(context).cardColor;
        final hintColor = isDark ? Colors.grey[400] : Colors.grey[600];
        final borderColor = isDark
            ? Colors.grey.shade700
            : Colors.grey.shade400;

        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Step 2 of 4",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "50%",
                        style: TextStyle(
                          fontSize: 14,
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
                      value: 0.5,
                      backgroundColor: isDark
                          ? Colors.grey.shade800
                          : Colors.grey[300],
                      color: Colors.redAccent,
                      minHeight: 6,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _label("Name (if known)", textColor),
                  const SizedBox(height: 10),

                  // NAME
                  TextField(
                    controller: controller.nameController,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: "Name (if known)",
                      labelStyle: TextStyle(color: hintColor),
                      hintText: "Enter name (if known)",
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _label("Gender", textColor),
                  const SizedBox(height: 10),

                  // GENDER DROPDOWN
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      dropdownColor: cardColor,
                      value: controller.gender.value,
                      style: TextStyle(color: textColor),
                      items: const [
                        DropdownMenuItem(value: 'male', child: Text('male')),
                        DropdownMenuItem(
                          value: 'female',
                          child: Text('female'),
                        ),
                        DropdownMenuItem(value: 'other', child: Text('other')),
                      ],
                      onChanged: (value) {
                        controller.gender.value = value!;
                      },
                      decoration: InputDecoration(
                        labelText: "Gender",
                        labelStyle: TextStyle(color: hintColor),
                        filled: true,
                        fillColor: cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: borderColor),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  _label("Estimated Age", textColor),
                  const SizedBox(height: 10),

                  // AGE
                  TextField(
                    controller: controller.ageController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: "Estimated Age",
                      labelStyle: TextStyle(color: hintColor),
                      hintText: "Enter estimated age",
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _label("Clothing Description", textColor),
                  const SizedBox(height: 10),

                  // CLOTHING
                  TextField(
                    controller: controller.clothingController,
                    maxLines: 2,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: "Clothing Description",
                      labelStyle: TextStyle(color: hintColor),
                      hintText: "Describe the clothing worn",
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _label("Behavioral Notes", textColor),
                  const SizedBox(height: 10),

                  // NOTES
                  TextField(
                    controller: controller.notesController,
                    maxLines: 2,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: "Behavioral Notes",
                      labelStyle: TextStyle(color: hintColor),
                      hintText: "Add any notable behavioral observations",
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // CONTINUE BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF140D44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      controller.onContinue();
                      Get.to(() => PhotoLocationScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  /// LABEL WIDGET
  Widget _label(String title, Color? textColor) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
