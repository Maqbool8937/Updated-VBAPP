import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/baggar_controller.dart';

class BeggarFormScreen extends StatelessWidget {
  final controller = Get.put(BeggarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beggars Registration Form")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            sectionTitle("Beggar Profile"),

            // Face Image
            Obx(
              () => GestureDetector(
                onTap: controller.pickFaceImage,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: controller.faceImage.value == null
                      ? const Center(child: Text("Tap to Upload Face Image"))
                      : Image.file(
                          controller.faceImage.value!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Fingerprint Image
            Obx(
              () => GestureDetector(
                onTap: controller.pickFingerprintImage,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: controller.fingerprintImage.value == null
                      ? const Center(
                          child: Text("Tap to Upload Fingerprint Image"),
                        )
                      : Image.file(
                          controller.fingerprintImage.value!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Name
            customTextField(
              "Name",
              onChanged: (v) => controller.name.value = v,
            ),

            // CNIC
            customTextField(
              "CNIC",
              onChanged: (v) => controller.cnic.value = v,
            ),

            // Age
            customTextField("Age", onChanged: (v) => controller.age.value = v),

            // Faith Dropdown
            dropdownField(
              title: "Faith",
              value: controller.faith,
              items: ["Islam", "Christian", "Hindu", "Sikh", "Other"],
            ),

            const SizedBox(height: 20),
            sectionTitle("Type of Beggar"),

            dropdownField(
              title: "Type of Beggar",
              value: controller.selectedBeggarType,
              items: [
                "Professional Beggar",
                "Forced Beggar",
                "Disabled Beggar",
                "Child Beggar",
                "Occasional Beggar",
                "Other",
              ],
            ),

            const SizedBox(height: 20),
            sectionTitle("Previous Record"),

            Obx(
              () => Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: controller.hasPreviousRecord.value,
                    onChanged: (v) => controller.hasPreviousRecord.value = v!,
                  ),
                  const Text("Yes"),
                  Radio(
                    value: false,
                    groupValue: controller.hasPreviousRecord.value,
                    onChanged: (v) => controller.hasPreviousRecord.value = v!,
                  ),
                  const Text("No"),
                ],
              ),
            ),

            Obx(
              () => controller.hasPreviousRecord.value
                  ? customTextField(
                      "Previous Record Details",
                      onChanged: (v) => controller.previousRecordText.value = v,
                    )
                  : Container(),
            ),

            const SizedBox(height: 20),
            sectionTitle("Addiction / Disability / Issue"),

            dropdownField(
              title: "Condition Type",
              value: controller.selectedIssue,
              items: [
                "Disability",
                "Injured",
                "Drug Addiction",
                "Mental Illness",
                "Chronic Disease",
                "Other Genuine Issue",
              ],
            ),

            const SizedBox(height: 20),
            sectionTitle("Additional Data"),

            customTextField(
              "Address",
              onChanged: (v) => controller.address.value = v,
            ),
            customTextField(
              "Notes",
              maxLines: 3,
              onChanged: (v) => controller.notes.value = v,
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: controller.submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Submit Record",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // Common Widgets ------------------------------

  Widget sectionTitle(String title) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
  );

  Widget customTextField(
    String label, {
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget dropdownField({
    required String title,
    required RxString value,
    required List<String> items,
  }) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: SizedBox(),
          hint: Text(title),
          value: value.value.isEmpty ? null : value.value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => value.value = v!,
        ),
      ),
    );
  }
}
