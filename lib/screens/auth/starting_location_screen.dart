import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/location/location_picker_screen.dart';
import 'package:wasly_template/core/widgets/text/text_button_1.dart';
import 'package:wasly_template/wasly_template.dart';

class StartingLocationScreen extends StatefulWidget {
  const StartingLocationScreen({super.key});

  @override
  State<StartingLocationScreen> createState() => _StartingLocationScreenState();
}

class _StartingLocationScreenState extends State<StartingLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const TextHeading4(
                        text: "Share Your Address With Us",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextParagraph3(
                        text:
                            "Please enter your location or allow access to your location to find food near you",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  AppConstants.getIconPath("map.png"),
                ),
                CustomTextButtonActive(
                  text: "Allow Locations",
                  onClick: () async {
                    await Get.to(() => LocationPickerScreen());
                  },
                  radius: 100,
                ),
                GestureDetector(
                  child: TextButton1(
                    text: "Skip for Now",
                    color: AppColors.primaryBase,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
