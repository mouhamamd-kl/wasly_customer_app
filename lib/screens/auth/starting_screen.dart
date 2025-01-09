import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/login_screen.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly_template/wasly_template.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 11),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                      AppConstants.getAssetPath("general/auth/bike_3d.png"),
                      fit: BoxFit.contain,
                      alignment: Alignment.center),
                  TextHeading3(
                    text: "Welcome!",
                  ),
                  TextParagraph3(
                    text: "We Are Preparing Something Great For You!",
                  ),

                  CustomIconButton(
                    text: "Continue With Google",
                    icon: AppConstants.getIconPath("google.svg"),
                    onClick: () {},
                  ),

                  // Flexible(
                  //   child: CustomIconButton(
                  //     text: "Apple",
                  //     icon: AppConstants.getIconPath("apple.svg"),
                  //     onClick: () {},
                  //   ),
                  // ),

                  CustomTextButtonWhite(
                    onClick: () async {
                      await Get.to(() => LoginScreen());
                    },
                    text: "Continue with Email or Phone",
                    radius: 100,
                  ),
                  CustomRichTextButton(
                    firstText: "Don’t have account? ",
                    secondText: "Sign Up",
                    onPressed: () async {
                      await Get.to(() => LoginScreen());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
