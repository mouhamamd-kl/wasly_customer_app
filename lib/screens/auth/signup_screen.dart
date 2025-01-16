import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/login_screen.dart';
import 'package:wasly/screens/auth/starting_location_screen.dart';
import 'package:wasly/screens/auth/verification_screen.dart';
import 'package:wasly_template/core/widgets/field/custom_password_field.dart';
import 'package:wasly_template/core/widgets/field/custom_text_field.dart';
import 'package:wasly_template/wasly_template.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                        text: "Let’s Create Account!",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    // const SizedBox(height: 8),
                    FittedBox(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextParagraph3(
                          text: "Enter your detail below to create new account",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 16),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Align(alignment: Alignment.center, child: SignUpForm()),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                // const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomRichTextButton(
                    firstText: "Already Have Account? ",
                    secondText: "Sign In",
                    onPressed: () {
                      Get.to(() => LoginScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 20,
        children: [
          CustomTextField(
            hintText: "Enter Your Email",
            defaultIcon: AppConstants.getIconPath("message.svg"),
            focusedIcon: AppConstants.getIconPath("message_off.svg"),
            onChanged: (email) {
              print("Email: $email");
            },
            onSaved: (email) {
              print("Saved Email: $email");
            },
          ),
          // const SizedBox(height: 8),
          CustomPhoneField(phoneNumberController: _phoneNumberController),
          // const SizedBox(height: 8),
          CustomPasswordField(
            controller: _passwordController,
            hintText: "Enter Your Password",
            onChanged: (email) {
              print("Email: $email");
            },
            onSaved: (email) {
              print("Saved Email: $email");
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              } else if (value.length < 8) {
                return "Password must be at least 8 characters long";
              }
              return null;
            },
          ),
          // const SizedBox(height: 8),
          CustomPasswordField(
            controller: _confirmPasswordController,
            hintText: "Confirm Your Password",
            onChanged: (email) {
              print("Email: $email");
            },
            onSaved: (email) {
              print("Saved Email: $email");
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirm password cannot be empty";
              } else if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          // const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: CustomTextButtonActive(
              radius: 100,
              text: "Continue",
              onClick: () async {
                await Get.to(() => StartingLocationScreen());
              },
            ),
          )
        ],
      ),
    );
  }
}
