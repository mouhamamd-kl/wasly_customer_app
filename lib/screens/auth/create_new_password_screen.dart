import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasly/screens/auth/password_created_successefully_screen.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly_template/core/widgets/field/custom_password_field.dart';
import 'package:wasly_template/core/widgets/field/custom_text_field.dart';
import 'package:wasly_template/wasly_template.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
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
                    text: "New Password",
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextParagraph3(
                    text: "Enter your new password and remember it.",
                    textAlign: TextAlign.center,
                  ),
                ),
                PasswordForm(),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordValid = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _isPasswordValid = password.isNotEmpty &&
          password == confirmPassword &&
          password.length >= 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomPasswordField(
            hintText: "Enter your password",
            controller: _passwordController,
            onChanged: (_) => _validatePasswords(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              } else if (value.length < 8) {
                return "Password must be at least 8 characters long";
              }
              return null;
            },
          ),
          CustomPasswordField(
            hintText: "Confirm your password",
            controller: _confirmPasswordController,
            onChanged: (_) => _validatePasswords(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirm password cannot be empty";
              } else if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomTextButtonActive(
              radius: 100,
              text: "Continue",
              onClick: _isPasswordValid
                  ? () async {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to the next screen
                        await Get.to(
                            () => const PasswordCreatedSuccessefullyScreen());
                      }
                    }
                  : null, // Disable the button if passwords are invalid
            ),
          ),
        ],
      ),
    );
  }
}
// class SignInForm extends StatefulWidget {
//   const SignInForm({super.key});

//   @override
//   State<SignInForm> createState() => _SignInFormState();
// }

// class _SignInFormState extends State<SignInForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   bool _isEmailValid = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   void _validateEmail(String email) {
//     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
//     setState(() {
//       _isEmailValid = emailRegex.hasMatch(email);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           spacing: 40,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomPasswordField(
//               hintText: "Enter your password",

//               // controller: _emailController,
//               onChanged: (value) {
//                 _validateEmail(value);
//               },
//             ),
//             CustomPasswordField(
//               hintText: "Confirm your password",

//               // controller: _emailController,
//               onChanged: (value) {
//                 _validateEmail(value);
//               },
//             ),
//             SizedBox(
//               width: MediaQuery.sizeOf(context).width,
//               child: CustomTextButtonActive(
//                 radius: 100,
//                 text: "Continue",
//                 onClick: _isEmailValid
//                     ? () async {
//                         // Navigate to the next screen
//                         await Get.to(() => SignupScreen());
//                       }
//                     : null, // Disable the button if email is invalid
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
