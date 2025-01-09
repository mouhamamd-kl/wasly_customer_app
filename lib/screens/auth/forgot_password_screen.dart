import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/create_new_password_screen.dart';
import 'package:wasly/screens/auth/password_created_successefully_screen.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly_template/core/widgets/field/custom_text_field.dart';
import 'package:wasly_template/wasly_template.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                Spacer(flex: 1),
                Align(
                  alignment: Alignment.center,
                  child: const TextHeading4(
                    text: "Forgot Password",
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextParagraph3(
                    text:
                        "Enter your email or phone to send a verification code",
                    textAlign: TextAlign.center,
                  ),
                ),
                SignInForm(),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    setState(() {
      _isEmailValid = emailRegex.hasMatch(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 40,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: "Enter your email",
              defaultIcon: AppConstants.getIconPath('message.svg'),
              focusedIcon: AppConstants.getIconPath('message-off.svg'),
              controller: _emailController,
              onChanged: (value) {
                _validateEmail(value);
              },
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: CustomTextButtonActive(
                radius: 100,
                text: "Continue",
                onClick: _isEmailValid
                    ? () async {
                        // Navigate to the next screen
                        await Get.to(() => CreateNewPasswordScreen());
                      }
                    : null, // Disable the button if email is invalid
              ),
            ),
          ],
        ),
      ),
    );
  }
}
