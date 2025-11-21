import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/login_controller.dart';
import 'package:vagrancy_beggars/view/widgets/custom_field.dart';

class WelcomeBackScreen extends StatelessWidget {
  WelcomeBackScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: mediaQuery.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff140D44), Color.fromARGB(255, 162, 67, 70)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.04,
                vertical: mediaQuery.height * 0.02,
              ),
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.height * 0.2),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'Please Sign in to Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: mediaQuery.height * 0.07),
                 
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'USERNAME',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  CustomField(
                    text: 'Enter your username',
                    controller: controller.usernameController,
                    isPrefixIcon: true,
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'PASSWORD',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomField(
                      text: 'Enter your password',
                      controller: controller.passwordController,
                      isPasswordField: true,
                      isObscured: controller.isPasswordHidden.value,
                      isPrefixIcon: true,
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      isSuffixIcon: true,
                      suffixIcon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onSuffixTap: controller.togglePassword,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: controller.forgotPassword,
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Color(0xffED1C24)),
                      ),
                    ),
                  ),
                  SizedBox(height: mediaQuery.height * 0.1),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          // onPressed:(){
                          //  Get.off(()=>MainNavScreen());
                          // }, 
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffED1C24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [Dot(), SizedBox(width: 10), Dot()],
                  ),
                //  SizedBox(height: mediaQuery.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xffED1C24),
        shape: BoxShape.circle,
      ),
    );
  }
}



