import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/final_step_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';

class FinalStepScreen extends StatelessWidget {
  const FinalStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FinalStepController());
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;
      final bgColor = Theme.of(context).scaffoldBackgroundColor;
      final textColor = Theme.of(context).textTheme.bodyLarge!.color;
      final cardColor = Theme.of(context).cardColor;

      return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
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
                      "Step 4 of 4 • Final Step",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "90%",
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
                    value: 0.9,
                    backgroundColor: isDark
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    color: Colors.redAccent,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 25),

                // Officer Notes
                Text(
                  "Officer Notes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 40,
                  height: 3,
                  color: isDark ? Colors.blueGrey : Colors.indigo.shade900,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.notesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Add any relevant case notes here...",
                    filled: true,
                    fillColor: isDark ? Colors.grey.shade900 : Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey.shade500 : Colors.grey,
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),

                const SizedBox(height: 30),

                // Shelter Assignment
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Shelter Assignment",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Optional",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent.shade200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  width: 40,
                  height: 3,
                  color: isDark ? Colors.blueGrey : Colors.indigo.shade900,
                ),
                const SizedBox(height: 10),

                // Dropdown
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedShelter.value.isEmpty
                        ? null
                        : controller.selectedShelter.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.home_work_outlined,
                        color: isDark ? Colors.grey.shade400 : Colors.grey,
                      ),
                      filled: true,
                      fillColor: isDark
                          ? Colors.grey.shade900
                          : Colors.grey[100],
                      hintText: "Select a shelter...",
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey.shade500 : Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: cardColor,
                    items: controller.shelterList
                        .map(
                          (shelter) => DropdownMenuItem<String>(
                            value: shelter,
                            child: Text(
                              shelter,
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedShelter.value = value ?? '';
                    },
                  ),
                ),

                const Spacer(),

                // Complete Registration button
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
                    onPressed: controller.onCompleteRegistration,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Complete Registration",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }
}
