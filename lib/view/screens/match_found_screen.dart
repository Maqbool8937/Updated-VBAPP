import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme%20_controller.dart';

class MatchFoundScreen extends StatefulWidget {
  const MatchFoundScreen({super.key});

  @override
  State<MatchFoundScreen> createState() => _MatchFoundScreenState();
}

class _MatchFoundScreenState extends State<MatchFoundScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final mediaQuery = MediaQuery.of(context).size;

    return Obx(() {
      final isDark = themeController.isDark.value;
      final bgColor = isDark ? Colors.black : Colors.white;
      final textColor = isDark ? Colors.white : const Color(0xff140D44);
      final cardColor = isDark ? Colors.grey.shade900 : Colors.white;

      return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.height * 0.06),

              /// HEADER BAR
              Container(
                height: mediaQuery.height * 0.1,
                width: mediaQuery.width,
                decoration: BoxDecoration(color: const Color(0xff140D44)),
                child: Center(
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    title: const Text(
                      'Match Found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
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

                    /// Name + Age
                    Text(
                      'Usama Kamal',
                      style: TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Age: 42',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor.withOpacity(0.8),
                      ),
                    ),

                    SizedBox(height: mediaQuery.height * 0.05),

                    /// Personal Details Heading
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Personal Details',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    /// FIRST INFO CARD
                    Container(
                      height: mediaQuery.height * 0.2,
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: mediaQuery.height * 0.02),
                            _infoRow(
                              icon: Icons.location_on,
                              text: 'Location Found: Lahore, Punjab',
                              textColor: textColor,
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            _infoRow(
                              icon: Icons.perm_identity,
                              text: 'Identification Marks: Scar on left cheek',
                              textColor: textColor,
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            _infoRow(
                              icon: Icons.alarm,
                              text: 'Last Seen: 3 days ago',
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: mediaQuery.height * 0.02),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Previous Details',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    /// SECOND INFO CARD
                    Container(
                      height: mediaQuery.height * 0.22,
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            SizedBox(height: mediaQuery.height * 0.02),
                            _infoRow(
                              icon: Icons.location_on,
                              text:
                                  'Previously Found at: Liberty Market,\n Lahore (Jan 15), Saddar Bazar',
                              textColor: textColor,
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            _infoRow(
                              icon: Icons.notes,
                              text: 'Notes: Has refused shelter twice',
                              textColor: textColor,
                            ),
                            SizedBox(height: mediaQuery.height * 0.02),
                            _infoRow(
                              icon: Icons.category,
                              text: 'Category: Repeat Offender',
                              iconColor: Colors.red,
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: mediaQuery.height * 0.05),

                    /// BUTTONS
                    // _outlinedButton(
                    //   text: "Mark Present Again",
                    //   textColor: Colors.white,
                    //   borderColor: const Color(0xff140D44),
                    // ),
                    _filledButton(
                      text: "Mark Present Again",
                      color: Colors.green,
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),
                    _filledButton(
                      text: "Take Action (FIR/Warning)",
                      color: const Color(0xffED1C24),
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),
                    _filledButton(
                      text: "Assign Shelter",
                      color: const Color(0xff140D44),
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

  /// --------------------------
  /// REUSABLE WIDGETS
  /// --------------------------

  Widget _infoRow({
    required IconData icon,
    required String text,
    Color iconColor = Colors.blueAccent,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 5),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 16, color: textColor)),
        ),
      ],
    );
  }

  Widget _outlinedButton({
    required String text,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _filledButton({required String text, required Color color}) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
