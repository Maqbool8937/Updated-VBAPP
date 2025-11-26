import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vagrancy_beggars/view/screens/UpdatedScreens/action_data.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/general_information.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/person_intercepted.dart';
import 'package:vagrancy_beggars/view/screens/UpdatedScreens/personal_data.dart';
import 'package:vagrancy_beggars/view/widgets/custom_button.dart';

class AddbaggersdataScreen extends StatelessWidget {
  const AddbaggersdataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),

        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Add Baggers Data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaquery.width * 0.03,
          vertical: mediaquery.height * 0.02,
        ),
        child: Column(
          children: [
            CustomButton(
              onTap: () {
                Get.to(() => GeneralInformation());
              },
              width: mediaquery.width,
              color: Colors.white,
              name: 'General Information',
            ),
            SizedBox(height: mediaquery.height * 0.02),
            CustomButton(
              onTap: () {
                Get.to(() => PersonIntercepted());
              },
              width: mediaquery.width,
              color: Colors.white,
              name: 'Person Intercepted',
            ),
            SizedBox(height: mediaquery.height * 0.02),
            CustomButton(
              onTap: () {
                Get.to(() => PersonalData());
              },
              width: mediaquery.width,
              color: Colors.white,
              name: 'Beggar Profile',
            ),
            SizedBox(height: mediaquery.height * 0.02),
            CustomButton(
              onTap: () {
                Get.to(() => ActionData());
              },
              width: mediaquery.width,
              color: Colors.white,
              name: 'Action Taken',
            ),
          ],
        ),
      ),
    );
  }
}
