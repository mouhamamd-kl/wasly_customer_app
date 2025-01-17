import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasly/models/customer.dart';
import 'package:wasly/screens/auth/login_screen.dart';
import 'package:wasly/screens/auth/starting_location_screen.dart';
import 'package:wasly/screens/auth/verification_screen.dart';
import 'package:wasly/widgets/date_field.dart';
import 'package:wasly/widgets/gender_select_widget.dart';
import 'package:wasly/widgets/gender_widget.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/core/widgets/field/custom_password_field.dart';
import 'package:wasly_template/core/widgets/field/custom_text_field.dart';
import 'package:wasly_template/wasly_template.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/services/auth/customer_auth_service.dart';
import 'package:wasly/models/customer.dart';

import 'package:image_picker/image_picker.dart';
import 'package:wasly_template/core/styles/custom_color_styles.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/core/widgets/text/text_button_1.dart';
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
        child: SingleChildScrollView(
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
                            text:
                                "Enter your detail below to create new account",
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
  final CustomerAuthService _authService = CustomerAuthService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String selectedGender = 'male';
  DateTime selectedDate = DateTime(2000, 11, 1);
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        final signupData = {
          'email': emailController.text,
          'password': _passwordController.text,
          'password_confirmation': _passwordController.text,
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'phone': _phoneNumberController.text,
          'gender': selectedGender,
          'birth_date': DateFormat('yyyy-MM-dd').format(selectedDate),
        };
        final Customer customer = await _authService.signup(signupData);

        // Navigate to starting location screen after successful signup
        Get.off(() => StartingLocationScreen());
      } catch (e) {
        print(e);
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 20,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          CustomTextField(
            controller: emailController,
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
          CustomTextField(
            controller: firstNameController,
            hintText: "first Name",
            defaultIcon: null,
            focusedIcon: null,
          ),
          CustomTextField(
            controller: lastNameController,
            hintText: "last Name",
            defaultIcon: null,
            focusedIcon: null,
          ),
          // const SizedBox(height: 8),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: DateFieldWidget(
                  selectedDate: selectedDate,
                  onSelectDate: _selectDate,
                ),
              ),
              Expanded(
                child: GenderSelectWidget(
                  selectedGender: selectedGender,
                  genders: genders,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          CustomPhoneField(
            phoneNumberController: _phoneNumberController,
          ),
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
          // const SizedBox(height: 8)
          // ,

          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: CustomTextButtonActive(
              radius: 100,
              text: isLoading ? "Loading..." : "Continue",
              onClick: isLoading ? null : _submitForm,
            ),
          )
        ],
      ),
    );
  }

  // ... (keep existing _buildGenderSelect method)
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final List<Map<String, String>> genders = [
    {
      "name": "male", // Exactly matches selectedGender
      "icon": "assets/icons/male.svg",
    },
    {
      "name": "female", // Exactly matches possible selectedGender value
      "icon": "assets/icons/female.svg",
    }
  ];

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }
}
