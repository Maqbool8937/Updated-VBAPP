import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              TextField(
                controller: controller.oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Old Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => controller.changePassword(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("Update Password"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
