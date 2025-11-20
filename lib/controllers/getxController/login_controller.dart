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
        children: [
          const Text(
            "Enter your email to receive a password reset link.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Enter Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      textConfirm: "Send Link",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.red,
      buttonColor: Colors.red,
      onConfirm: () {
        if (emailController.text.isEmpty) {
          Get.snackbar(
            "Error",
            "Please enter an email.",
            backgroundColor: Colors.white,
            colorText: Colors.black,
          );
          return;
        }

        // TODO: Call forgot password API

        Get.back();
        Get.snackbar(
          "Success",
          "Password reset link sent to ${emailController.text}",
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
      },
    );
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.white,
        colorText: Colors.black,
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
        "Welcome ${result['user']['username']}",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Login Failed",
        e.toString(),
        backgroundColor: Colors.white,
        colorText: Colors.black,
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




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vagrancy_beggars/services/auth_service.dart';
// import 'package:vagrancy_beggars/view/screens/nav_bar_screen.dart';

// class LoginController extends GetxController {
//   // Text Controllers
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   // Observable variables
//   var isPasswordHidden = true.obs;
//   var isLoading = false.obs;

//   // AuthService instance
//   final AuthService _authService = AuthService();

//   // Toggle password visibility
//   void togglePassword() {
//     isPasswordHidden.value = !isPasswordHidden.value;
//   }

//   // Forgot password dialog
//   void forgotPassword() {
//     final emailController = TextEditingController();

//     Get.defaultDialog(
//       title: "Reset Password",
//       titleStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 20,
//         color: Colors.black,
//       ),
//       backgroundColor: Colors.white,
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Enter your email to receive a password reset link.",
//             style: TextStyle(fontSize: 14),
//           ),
//           const SizedBox(height: 15),
//           TextField(
//             controller: emailController,
//             decoration: InputDecoration(
//               hintText: "Enter Email",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ],
//       ),
//       textConfirm: "Send Link",
//       textCancel: "Cancel",
//       confirmTextColor: Colors.white,
//       cancelTextColor: Colors.red,
//       buttonColor: Colors.red,
//       onConfirm: () {
//         if (emailController.text.isEmpty) {
//           Get.snackbar(
//             "Error",
//             "Please enter an email.",
//             backgroundColor: Colors.white,
//             colorText: Colors.black,
//           );
//           return;
//         }

//         // TODO: Call your forgot password API here

//         Get.back(); // close dialog
//         Get.snackbar(
//           "Success",
//           "Password reset link sent to ${emailController.text}",
//           backgroundColor: Colors.white,
//           colorText: Colors.black,
//         );
//       },
//     );
//   }

//   // Login function
//   Future<void> login() async {
//     final username = usernameController.text.trim();
//     final password = passwordController.text.trim();

//     if (username.isEmpty || password.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please fill all fields",
//         backgroundColor: Colors.white,
//         colorText: Colors.black,
//       );
//       return;
//     }

//     try {
//       isLoading.value = true;
//       final result = await _authService.login(username, password);
//       isLoading.value = false;

//       // Navigate to main screen on success
//       Get.off(() => MainNavScreen());

//       Get.snackbar(
//         "Success",
//         "Welcome ${result['user']['username']}",
//         backgroundColor: Colors.white,
//         colorText: Colors.black,
//       );
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar(
//         "Login Failed",
//         e.toString(),
//         backgroundColor: Colors.white,
//         colorText: Colors.black,
//       );
//     }
//   }

//   // Dispose controllers when not needed
//   @override
//   void onClose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }



