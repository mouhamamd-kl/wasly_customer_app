import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/login_screen.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly_template/core/widgets/field/custom_text_field.dart';
import 'package:wasly_template/wasly_template.dart';

class PasswordCreatedSuccessefullyScreen extends StatelessWidget {
  const PasswordCreatedSuccessefullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 40,
                children: [
                  Container(
                    // child: SvgPicture.asset("assets/icons/lock.svg"),
                    child: Image.asset(AppConstants.getIconPath("lock.png")),
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color.fromRGBO(244, 253, 250, 1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: const TextHeading4(
                      text: "New password set successfully",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextParagraph3(
                      text:
                          "Congratulations! Your password has been set successfully. Please proceed to the login screen to verify your account.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: CustomTextButtonActive(
                        radius: 100,
                        text: "Continue",
                        onClick: () async {
                          // Navigate to the next screen
                          await Get.to(() => LoginScreen());
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
