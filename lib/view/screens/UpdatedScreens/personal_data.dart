import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/LinkedMafia_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/baggery_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/gender_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/generalinformation_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/langauage_dropdown_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/linked2_controller.dart';
import 'package:vagrancy_beggars/controllers/getxController/previous_record_controller.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/action_data.dart';
import 'package:vagrancy_beggars/view/widgets/baggery_widget.dart';
import 'package:vagrancy_beggars/view/widgets/costom_text_field.dart';
import 'package:vagrancy_beggars/view/widgets/gender_widget.dart';
import 'package:vagrancy_beggars/view/widgets/linked2_widget.dart';
import 'package:vagrancy_beggars/view/widgets/linled_mafia_widget.dart';
import 'package:vagrancy_beggars/view/widgets/previos_record_widget.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final GeneralInformationController controller = Get.put(
    GeneralInformationController(),
  );
  final GenderController genderController = Get.put(GenderController());
  final LanguagePickerController dropController = Get.put(
    LanguagePickerController(),
  );
  final LinkedmafiaController mafiaController = Get.put(
    LinkedmafiaController(),
  );
  final PreRecController preRecController = Get.put(PreRecController());
  final Linked2Controller link2Controller = Get.put(Linked2Controller());
  final BaggeryController baggeryController = Get.put(BaggeryController());

  // Text field controllers
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController permanentAddressController =
      TextEditingController();
  final TextEditingController presentAddressController =
      TextEditingController();
  final TextEditingController originalCityController = TextEditingController();
  final TextEditingController typeOfBeggaryController = TextEditingController();
  final TextEditingController previousRecordController =
      TextEditingController();
  final TextEditingController additionalNotesController =
      TextEditingController();

  // Reactive error messages
  final RxString cnicError = "".obs;
  final RxString fullNameError = "".obs;
  final RxString fatherNameError = "".obs;
  final RxString ageError = "".obs;

  // Progress percentage for this screen
  final double progress = 0.8; // 80%

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
          'Baggar Profile',
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
              // Progress Bar
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

              // CNIC
              _buildLabel('CNIC Number', mediaQuery),
              Obx(
                () => CustomTextField(
                  controller: cnicController,
                  hintText: "Without dashes (13 digits)",
                  errorText: cnicError.value.isEmpty ? null : cnicError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.025),

              // Full Name
              _buildLabel('Full Name', mediaQuery),
              Obx(
                () => CustomTextField(
                  controller: fullNameController,
                  hintText: "Enter full name",
                  errorText: fullNameError.value.isEmpty
                      ? null
                      : fullNameError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.025),

              // Father/Husband Name
              _buildLabel('Father/Husband Name', mediaQuery),
              Obx(
                () => CustomTextField(
                  controller: fatherNameController,
                  hintText: "Enter name",
                  errorText: fatherNameError.value.isEmpty
                      ? null
                      : fatherNameError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.025),

              // Gender
              _buildLabel('Gender', mediaQuery),
              LinledMafiaWidget(),
              // GenderWidget(),
              SizedBox(height: mediaQuery.height * 0.025),

              // Age
              _buildLabel('Age', mediaQuery),
              Obx(
                () => CustomTextField(
                  controller: ageController,
                  hintText: "e.g 24",
                  errorText: ageError.value.isEmpty ? null : ageError.value,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.025),

              // Permanent Address
              _buildLabel('Permanent Address', mediaQuery),
              CustomTextField(
                controller: permanentAddressController,
                hintText: "",
              ),
              SizedBox(height: mediaQuery.height * 0.025),

              // Present Address
              _buildLabel('Present Address', mediaQuery),
              CustomTextField(
                controller: presentAddressController,
                hintText: "",
              ),
              SizedBox(height: mediaQuery.height * 0.025),

              // Original City/District
              _buildLabel('Original (City/District)', mediaQuery),
              CustomTextField(controller: originalCityController, hintText: ""),
              SizedBox(height: mediaQuery.height * 0.025),

              // Linked to Mafia
              _buildLabel('Linked to Mafia', mediaQuery),
              Linked2Widget(),
              SizedBox(height: mediaQuery.height * 0.025),

              // Type of Beggary
              _buildLabel('Type of Beggary', mediaQuery),
              BaggeryWidget(),
              SizedBox(height: mediaQuery.height * 0.025),

              // Previous Record
              _buildLabel('Previous Record', mediaQuery),
              PreviosRecordWidget(),
              SizedBox(height: mediaQuery.height * 0.025),

              // Additional Notes
              _buildLabel('Additional Notes', mediaQuery),
              CustomTextField(
                controller: additionalNotesController,
                hintText: "Any other information",
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
                  onPressed: _handleSubmit,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: mediaQuery.width * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Size mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.height * 0.008),
      child: Text(
        text,
        style: TextStyle(
          fontSize: mediaQuery.width * 0.04,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _handleSubmit() {
    Get.to(() => ActionData());
    // Reset errors
    cnicError.value = "";
    fullNameError.value = "";
    fatherNameError.value = "";
    ageError.value = "";

    bool isValid = true;
    if (cnicController.text.trim().isEmpty) {
      cnicError.value = "CNIC is required";
      isValid = false;
    }
    if (fullNameController.text.trim().isEmpty) {
      fullNameError.value = "Full Name is required";
      isValid = false;
    }
    if (fatherNameController.text.trim().isEmpty) {
      fatherNameError.value = "Father/Husband Name is required";
      isValid = false;
    }
    if (ageController.text.trim().isEmpty) {
      ageError.value = "Age is required";
      isValid = false;
    }

    if (isValid) {
      Get.snackbar(
        "Success",
        "All required fields are valid",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
