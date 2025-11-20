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
                  SizedBox(height: mediaQuery.height * 0.1),
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
                  SizedBox(height: mediaQuery.height * 0.05),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'LOGIN AS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const CustomField(
                    text: 'Circle Office',
                    isSuffixIcon: true,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
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
                  SizedBox(height: mediaQuery.height * 0.06),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
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
                  SizedBox(height: mediaQuery.height * 0.05),
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vagrancy_beggars/controllers/getxController/login_controller.dart';
// import 'package:vagrancy_beggars/view/screens/nav_bar_screen.dart';
// import 'package:vagrancy_beggars/view/widgets/custom_field.dart';

// class WelcomeBackScreen extends StatelessWidget {
//   WelcomeBackScreen({super.key});

//   final LoginController controller = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xff140D44), Color.fromARGB(255, 162, 67, 70)],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: mediaQuery.width * 0.04,
//                 vertical: mediaQuery.height * 0.02,
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: mediaQuery.height * 0.1),

//                   // Title
//                   Text(
//                     'Welcome Back!',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 34,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     'Please Sign in to Continue',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),

//                   SizedBox(height: mediaQuery.height * 0.05),

//                   // LOGIN AS
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Text(
//                         'LOGIN AS',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   CustomField(
//                     text: 'Circle Office',
//                     isSuffixIcon: true,
//                     suffixIcon: Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.white,
//                     ),
//                   ),

//                   SizedBox(height: mediaQuery.height * 0.02),

//                   // USERNAME
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Text(
//                         'USERNAME',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   CustomField(
//                     text: 'Enter your username',
//                     controller: controller.usernameController,
//                     isPrefixIcon: true,
//                     prefixIcon: Icon(Icons.person, color: Colors.white),
//                   ),

//                   SizedBox(height: mediaQuery.height * 0.02),

//                   // PASSWORD
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Text(
//                         'PASSWORD',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),

//                   Obx(
//                     () => CustomField(
//                       text: 'Enter your password',
//                       controller: controller.passwordController,
//                       isPasswordField: true,
//                       isObscured: controller.isPasswordHidden.value,
//                       isPrefixIcon: true,
//                       prefixIcon: Icon(Icons.lock, color: Colors.white),
//                       isSuffixIcon: true,
//                       suffixIcon: Icon(
//                         controller.isPasswordHidden.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.white,
//                       ),
//                       onSuffixTap: controller.togglePassword,
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: TextButton(
//                       onPressed: controller.forgotPassword,
//                       child: Text(
//                         'Forgot Password',
//                         style: TextStyle(color: Color(0xffED1C24)),
//                       ),
//                     ),
//                   ),

//                   SizedBox(height: mediaQuery.height * 0.06),

//                   // SIGN IN BUTTON
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 55,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           controller.login();
//                           Get.to(() => MainNavScreen());
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xffED1C24),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: const Text(
//                           "SIGN IN",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // Dots indicator
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [Dot(), SizedBox(width: 10), Dot()],
//                   ),

//                   SizedBox(height: mediaQuery.height * 0.05),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Dot extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 10,
//       height: 10,
//       decoration: const BoxDecoration(
//         color: Color(0xffED1C24),
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }
