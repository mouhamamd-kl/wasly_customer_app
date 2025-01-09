import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly_template/core/widgets/field/custom_password_field.dart';
import 'package:wasly_template/core/widgets/field/custom_text_field.dart';
import 'package:wasly_template/wasly_template.dart';

class EmailConfirmScreen extends StatelessWidget {
  const EmailConfirmScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [TextButton(onPressed: () {}, child: Text("data"))],
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
                Spacer(
                  flex: 1,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const TextHeading4(
                    text: "Verify Your Account!",
                    textAlign: TextAlign.start,
                  ),
                ),
                // const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: TextParagraph3(
                    text: "We send a code on your phone number +44*******964",
                    textAlign: TextAlign.center,
                  ),
                ),

                // const SizedBox(height: 16),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                // const SizedBox(height: 16),

                SignInForm(),
                Spacer(
                  flex: 2,
                ),
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
  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("Phone Number: ${_phoneNumberController.text}");
    } else {
      print("Validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
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
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Opacity(
                  opacity: 0.4,
                  child: TextHeading10(
                    text: "Resend",
                    textAlign: TextAlign.center,
                  ),
                ),
                TextHeading10(
                  text: "in 00:30",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: CustomTextButtonActive(
                radius: 100,
                text: "Continue",
                onClick: () async {
                  await Get.to(() => SignupScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
