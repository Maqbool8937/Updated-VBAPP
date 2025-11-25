import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/config/change_password_service.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> changePassword() async {
    final oldPwd = oldPasswordController.text.trim();
    final newPwd = newPasswordController.text.trim();
    final confirmPwd = confirmPasswordController.text.trim();

    if (oldPwd.isEmpty || newPwd.isEmpty || confirmPwd.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (newPwd != confirmPwd) {
      Get.snackbar("Error", "New passwords do not match");
      return;
    }

    isLoading(true);

    final response = await ChangePasswordService.changePassword(
      oldPassword: oldPwd,
      newPassword: newPwd,
    );

    isLoading(false);

    if (response["success"]) {
      Get.snackbar("Success", "Password updated successfully");
      Get.back();
    } else {
      Get.snackbar(
        "Error",
        response["data"]?["message"] ?? "Failed to change password",
      );
    }
  }
}
