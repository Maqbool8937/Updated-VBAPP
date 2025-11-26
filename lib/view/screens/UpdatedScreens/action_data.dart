import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/action_take_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/langauage_dropdown_controller.dart';
import 'package:vagrancy_beggars/view/widgets/action_taken_widget.dart';

class ActionData extends StatefulWidget {
  const ActionData({super.key});

  @override
  State<ActionData> createState() => _ActionDataState();
}

class _ActionDataState extends State<ActionData> {
  final ActionTakController controller = Get.put(ActionTakController());
  final LanguagePickerController dropController = Get.put(
    LanguagePickerController(),
  );

  // Progress for this screen
  final double progress = 1.0; // 100%

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
          'Action Taken',
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
              // Progress bar
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

              // Action Type Label
              Text(
                'Select action type',
                style: TextStyle(
                  fontSize: mediaQuery.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.015),

              // Action Type Widget
              ActionTakenWidget(),
              SizedBox(height: mediaQuery.height * 0.03),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your submit logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    side: BorderSide.none,
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.height * 0.018,
                    ),
                  ),
                  child: Text(
                    'Save Record',
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
