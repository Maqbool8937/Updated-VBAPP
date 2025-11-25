import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/language_controller.dart';

class LanguageScreen extends StatelessWidget {
  final controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('language'.tr)),
      body: Obx(
        () => Column(
          children: [
            RadioListTile(
              value: 'en_US',
              groupValue: controller.selectedLang.value,
              title: Text('english'.tr),
              onChanged: (value) {
                controller.changeLanguage(value.toString());
              },
            ),
            RadioListTile(
              value: 'ur_PK',
              groupValue: controller.selectedLang.value,
              title: Text('urdu'.tr),
              onChanged: (value) {
                controller.changeLanguage(value.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
