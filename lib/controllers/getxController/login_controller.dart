import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/services/auth_service.dart';
import 'package:vagrancy_beggars/view/screens/nav_bar_screen.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  final AuthService _authService = AuthService();

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void forgotPassword() {
    final emailController = TextEditingController();
    var isLoading = false.obs;

    Get.defaultDialog(
      title: "Reset Password",
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter your email to receive a password reset link.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() => isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox()),
        ],
      ),
      textConfirm: "Send Link",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.red,
      buttonColor: Colors.red,
      onConfirm: () async {
        final email = emailController.text.trim();
        
        if (email.isEmpty) {
          Get.snackbar(
            "Error",
            "Please enter an email.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // Basic email validation
        if (!GetUtils.isEmail(email)) {
          Get.snackbar(
            "Error",
            "Please enter a valid email address.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        try {
          isLoading.value = true;
          await _authService.forgotPassword(email);
          isLoading.value = false;
          
          Get.back();
          Get.snackbar(
            "Success",
            "Password reset link sent to $email",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        } catch (e) {
          isLoading.value = false;
          Get.snackbar(
            "Error",
            e.toString().replaceAll('Exception: ', ''),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validation
    final usernameError = validateUsername(username);
    final passwordError = validatePassword(password);

    if (usernameError != null || passwordError != null) {
      Get.snackbar(
        "Validation Error",
        usernameError ?? passwordError ?? "Please fill all fields correctly",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final result = await _authService.login(username, password);
      isLoading.value = false;

      Get.off(() => MainNavScreen());
      Get.snackbar(
        "Success",
        "Welcome ${result['user']['username'] ?? 'User'}",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      Get.snackbar(
        "Login Failed",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}




