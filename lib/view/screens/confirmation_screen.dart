import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/view/screens/nav_bar_screen.dart';
import 'package:vagrancy_beggars/view/screens/settings_logout.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final mediaQuery = MediaQuery.of(context).size;

    return Obx(() {
      final isDark = themeController.isDark.value;
      final bgColor = Theme.of(context).scaffoldBackgroundColor;
      final cardColor = Theme.of(context).cardColor;
      final textColor = Theme.of(context).textTheme.bodyLarge!.color;

      return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.height * 0.06),
              Container(
                height: mediaQuery.height * 0.1,
                width: mediaQuery.width,
                decoration: BoxDecoration(color: Colors.green.shade600),
                child: Center(
                  child: Text(
                    'Profile Created',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.03),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.03,
                  vertical: mediaQuery.height * 0.02,
                ),
                child: Column(
                  children: [
                    SizedBox(height: mediaQuery.height * 0.04),
                    // Profile Info Card
                    Container(
                      height: mediaQuery.height * 0.35,
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cardColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: mediaQuery.height * 0.06),
                            Text(
                              'Usama Kamal',
                              style: TextStyle(fontSize: 22, color: textColor),
                            ),
                            Text(
                              'Age: 42',
                              style: TextStyle(fontSize: 18, color: textColor),
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            Row(
                              children: [
                                Icon(
                                  Icons.perm_identity,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '42301-23457833-1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.blueAccent),
                                SizedBox(width: 5),
                                Text(
                                  '(212)123-234)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'Liberty Market, Saddar Bazaar, Lahore',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQuery.height * 0.03),

                    // About Card
                    Container(
                      height: mediaQuery.height * 0.23,
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: mediaQuery.height * 0.02),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            Text(
                              'Page layouts look better with something in each section. Web page designers, content writers, editorials, and filler before the final written content',
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQuery.height * 0.03),

                    // Skills Card
                    Container(
                      height: mediaQuery.height * 0.23,
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: mediaQuery.height * 0.02),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Skills',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(height: mediaQuery.height * 0.01),
                            Row(
                              children: [
                                _skillBox('Resilience', mediaQuery),
                                SizedBox(width: mediaQuery.width * 0.02),
                                _skillBox('Adaptability', mediaQuery),
                                SizedBox(width: mediaQuery.width * 0.02),
                                _skillBox('Street Smarts', mediaQuery),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height * 0.01),
                            Row(
                              children: [
                                _skillBox('Negotiation', mediaQuery),
                                SizedBox(width: mediaQuery.width * 0.02),
                                _skillBox('Storytelling', mediaQuery),
                                SizedBox(width: mediaQuery.width * 0.02),
                                _skillBox('Patience', mediaQuery),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height * 0.01),
                            Row(
                              children: [
                                _skillBox('Endurance', mediaQuery),
                                SizedBox(width: mediaQuery.width * 0.02),
                                _skillBox('Creativity', mediaQuery),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: mediaQuery.height * 0.05),

                    // Edit Profile Button
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SettingsLogout());
                      },
                      child: Container(
                        height: mediaQuery.height * 0.07,
                        width: mediaQuery.width,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.grey.shade900
                              : Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xff140D44),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Color(0xff140D44),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: mediaQuery.height * 0.02),

                    // Confirm Button
                    GestureDetector(
                      onTap: () {
                        Get.to(() => MainNavScreen());
                      },
                      child: Container(
                        height: mediaQuery.height * 0.07,
                        width: mediaQuery.width,
                        decoration: BoxDecoration(
                          color: Color(0xff140D44),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.05),
            ],
          ),
        ),
      );
    });
  }

  Widget _skillBox(String title, Size mediaQuery) {
    return Container(
      height: mediaQuery.height * 0.03,
      width: mediaQuery.width * 0.22,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(title)),
    );
  }
}
