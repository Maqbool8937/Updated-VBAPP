import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/view/screens/welcome_back_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Column(
            children: [
              SizedBox(height: size.height * 0.2),

              // 🔹 LOGO CIRCLE
              // Container(
              //   width: 120,
              //   height: 120,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(color: Colors.redAccent, width: 3),
              //   ),
              //   child: const Center(
              //     child: Icon(
              //       Icons.verified_user,
              //       color: Colors.white,
              //       size: 50,
              //     ),
              //   ),
              // ),

              Container(
                height: size.height*0.15,
                width: size.width*0.36,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  //image: DecorationImage(image: AssetImage('assets/images/icon.jpeg')),

                 // borderRadius: BorderRadius.circular(50)
                ),
               child: CircleAvatar(foregroundImage: AssetImage('assets/images/icon.jpeg'),),
                
                ),
              const SizedBox(height: 40),

              // 🔹 TITLE
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: const Text(
                    textAlign: TextAlign.center,
                    "Punjab Beggars & Vagrancy Portal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 🔹 SUBTITLE
              const Text(
                "For Safer Streets in Lahore",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),

              SizedBox(height: size.height * 0.28),

              // 🔹 BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => WelcomeBackScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffED1C24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 DOTS INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _dot(active: true),
                  const SizedBox(width: 8),
                  _dot(active: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 DOT WIDGET
  Widget _dot({required bool active}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: active ? const Color(0xffED1C24) : Colors.white24,
        shape: BoxShape.circle,
      ),
    );
  }
}
