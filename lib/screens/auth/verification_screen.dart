import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly/screens/auth/starting_location_screen.dart';
import 'package:wasly_template/wasly_template.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // actions: [TextButton(onPressed: () {}, child: Text("data"))],
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
                    text: "Verify Your Account!",
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextParagraph3(
                    text: "We sent a code on your phone number +44*******964",
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
  final _phoneNumberController = TextEditingController();
  int _secondsRemaining = 30;
  late Timer _timer;
  bool _isTimerRunning = true;
  bool _isOtpValid = false; // Tracks OTP validity

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isTimerRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    setState(() {
      _secondsRemaining = 30;
      _isTimerRunning = true;
    });
    _startTimer();
    print("Resend code triggered");
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
            OtpTextField(
              fieldHeight: 52,
              fieldWidth: 52,
              numberOfFields: 5,
              borderRadius: BorderRadius.circular(16),
              textStyle: CustomResponsiveTextStyles.headingH8,
              fillColor: AppColors.primaryBase,
              focusedBorderColor: AppColors.primaryBase,
              borderColor: const Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                setState(() {
                  if (code == "00000") {
                    _isOtpValid = true; // Enable the button
                  } else {
                    _isOtpValid = false; // Disable the button
                  }
                });
              },
              onSubmit: (String verificationCode) {
                setState(() {
                  if (verificationCode == "00000") {
                    _isOtpValid = true; // Enable the button
                  } else {
                    _isOtpValid = false; // Disable the button
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              'Invalid Verification Code. Please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: _isTimerRunning ? null : _resendCode,
                  child: Opacity(
                    opacity: _isTimerRunning ? 0.4 : 1.0,
                    child: Text(
                      "Resend",
                      textAlign: TextAlign.center,
                      style: CustomResponsiveTextStyles.headingH10.copyWith(
                        color: _isTimerRunning
                            ? Colors.grey
                            : AppColors.primaryBase,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                TextHeading10(
                  text: _isTimerRunning
                      ? "in 00:${_secondsRemaining.toString().padLeft(2, '0')}"
                      : "",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: CustomTextButtonActive(
                radius: 100,
                text: "Continue",
                onClick: _isOtpValid
                    ? () async {
                        await Get.to(() => StartingLocationScreen());
                      }
                    : null, // Disable the button if OTP is invalid
              ),
            ),
          ],
        ),
      ),
    );
  }
}
