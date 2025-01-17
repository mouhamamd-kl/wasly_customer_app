// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:io';
// import 'package:intl/intl.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:wasly_template/core/styles/custom_color_styles.dart';
// import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
// import 'package:wasly_template/core/widgets/text/text_button_1.dart';
// import 'package:wasly_template/wasly_template.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController phoneNumberController = TextEditingController();
//   String selectedGender = 'Male';
//   DateTime selectedDate = DateTime(2000, 11, 1);

// Future<void> _selectDate(BuildContext context) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate,
//     firstDate: DateTime(1900),
//     lastDate: DateTime.now(),
//     builder: (context, child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(
//             primary: Colors.purple,
//             onPrimary: Colors.white,
//             onSurface: Colors.black,
//           ),
//         ),
//         child: child!,
//       );
//     },
//   );
//   if (picked != null && picked != selectedDate) {
//     setState(() {
//       selectedDate = picked;
//     });
//   }
// }

// Widget _buildDateField() {
//   return InkWell(
//     onTap: () => _selectDate(context),
//     child: Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: AppColors.strokColor,
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.calendar_today,
//             size: 20,
//             color: Colors.grey[600],
//           ),
//           const SizedBox(width: 12),
//           Text(
//             DateFormat('d/MM/yyyy').format(selectedDate),
//             style: CustomResponsiveTextStyles.fieldText1,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// final List<Map<String, String>> genders = [
//   {
//     "name": "Male",
//     "icon": "assets/icons/male.svg",
//   },
//   {
//     "name": "Female",
//     "icon": "assets/icons/female.svg",
//   }
// ];
// Future<void> _pickImage() async {
//   try {
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1000,
//       maxHeight: 1000,
//       imageQuality: 85,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   } catch (e) {
//     debugPrint('Error picking image: $e');
//   }
// }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       print("Phone Number: ${phoneNumberController.text}");
//     } else {
//       print("Validation failed");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "Edit Profile",
//           style: CustomResponsiveTextStyles.buttonText1.copyWith(
//             color: AppColors.textPrimaryBase,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Handle save
//             },
//             child: const TextButton1(
//               text: "Save",
//               color: AppColors.primaryBase,
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             spacing: 20,
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.grey[200],
//                       backgroundImage: _imageFile != null
//                           ? FileImage(_imageFile!) as ImageProvider
//                           : const NetworkImage(
//                               'https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg'),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: const BoxDecoration(
//                           color: Colors.purple,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(
//                 hintText: "Name",
//                 defaultIcon: null,
//                 focusedIcon: null,
//               ),
//               CustomTextField(
//                 hintText: "Email",
//                 defaultIcon: null,
//                 focusedIcon: null,
//               ),
//               CustomPhoneField(
//                 formKey: _formKey,
//                 phoneNumberController: phoneNumberController,
//               ),
//               Row(
//                 spacing: 10,
//                 children: [
//                   Expanded(
//                     child: _buildDateField(),
//                   ),
//                   Expanded(
//                     child: _buildGenderSelect(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 width: double.infinity,
//                 child: TextButton(
//                   onPressed: () {
//                     // Handle logout
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.red,
//                   ),
//                   child: const TextButton1(
//                     text: "logout",
//                     color: AppColors.errorBase,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderSelect() {
//     return DropdownButtonFormField2<String>(
//       value: selectedGender,
//       isExpanded: true,
//       style: CustomResponsiveTextStyles.fieldText4.copyWith(
//         color: AppColors.textSecondaryBase,
//       ),
//       decoration: InputDecoration(
//         enabledBorder: CustomOutlineInputBorder.defaultBorder(),
//         focusedBorder: CustomOutlineInputBorder.focusedBorder(),
//       ),
//       items: genders
//           .map(
//             (item) => DropdownMenuItem<String>(
//               value: item['name'],
//               child: GenderWidget(
//                 gender: item['name']!,
//                 icon: item['icon']!,
//               ),
//             ),
//           )
//           .toList(),
//       validator: (value) {
//         if (value == null) {
//           return 'Please select a gender.';
//         }
//         return null;
//       },
//       onChanged: (value) {
//         if (value != null) {
//           setState(() {
//             selectedGender = value;
//           });
//         }
//       },
//       buttonStyleData: const ButtonStyleData(
//         padding: EdgeInsets.only(right: 8),
//       ),
//       iconStyleData: const IconStyleData(
//         icon: Icon(
//           Icons.arrow_drop_down,
//           color: Colors.black45,
//         ),
//         iconSize: 24,
//       ),
//       dropdownStyleData: DropdownStyleData(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       menuItemStyleData: const MenuItemStyleData(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//       ),
//     );
//   }
// }

// class GenderWidget extends StatelessWidget {
//   const GenderWidget({
//     super.key,
//     required this.gender,
//     required this.icon,
//   });

//   final String gender;
//   final String icon;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SvgPicture.asset(
//           icon,
//           width: 20,
//           height: 20,
//         ),
//         const SizedBox(width: 10),
//         Text(
//           gender,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/services/auth/customer_auth_service.dart';
import 'package:wasly/models/customer.dart';

import 'package:image_picker/image_picker.dart';
import 'package:wasly/screens/auth/login_screen.dart';
import 'package:wasly/widgets/gender_widget.dart';
import 'package:wasly_template/core/styles/custom_color_styles.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/core/widgets/text/text_button_1.dart';
import 'package:wasly_template/wasly_template.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final CustomerAuthService _authService = CustomerAuthService();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String selectedGender = 'male';
  DateTime selectedDate = DateTime(2000, 11, 1);
  Customer? currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      setState(() => isLoading = true);
      final customer = await _authService.getCustomerInfo();
      setState(() {
        currentUser = customer;
        nameController.text = customer.firstName ?? '';
        emailController.text = customer.email ?? '';
        phoneNumberController.text = customer.phone ?? '';
        selectedGender = customer.gender ?? 'male';
        if (customer.birthDate != null) {
          selectedDate = DateTime.parse(customer.birthDate.toString()!);
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user information');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _handleLogout() async {
    try {
      await _authService.logout();
      Get.offAll(LoginScreen()); // Navigate to login screen
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to logout: ${e.toString()}');
    }
  }

  Future<void> _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final updateData = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
        'gender': selectedGender,
        'birth_date': DateFormat('yyyy-MM-dd').format(selectedDate),
      };

      await _authService.updateCustomer(currentUser!.id!, updateData);
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
    }
  }

  // ... (keep existing _selectDate, _buildDateField, and other helper methods)

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: CustomResponsiveTextStyles.buttonText1.copyWith(
            color: AppColors.textPrimaryBase,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _handleUpdate,
            child: const TextButton1(
              text: "Save",
              color: AppColors.primaryBase,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider
                            : NetworkImage(currentUser!.photo ??
                                "https://i.imgur.com/6HfdO4H.jpeg"),
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
                const SizedBox(height: 30),
                CustomTextField(
                  controller: nameController,
                  hintText: "Name",
                  defaultIcon: null,
                  focusedIcon: null,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  defaultIcon: null,
                  focusedIcon: null,
                ),
                CustomPhoneField(
                  phoneNumberController: phoneNumberController,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: _buildDateField(),
                    ),
                    Expanded(
                      child: _buildGenderSelect(),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _handleLogout,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const TextButton1(
                      text: "logout",
                      color: AppColors.errorBase,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

  Widget _buildGenderSelect() {
    return DropdownButtonFormField2<String>(
      value: selectedGender,
      isExpanded: true,
      style: CustomResponsiveTextStyles.fieldText4.copyWith(
        color: AppColors.textSecondaryBase,
      ),
      decoration: InputDecoration(
        enabledBorder: CustomOutlineInputBorder.defaultBorder(),
        focusedBorder: CustomOutlineInputBorder.focusedBorder(),
      ),
      items: genders
          .map(
            (item) => DropdownMenuItem<String>(
              value:
                  item['name'], // This should match exactly with selectedGender
              child: GenderWidget(
                gender: item['name']!,
                icon: item['icon']!,
              ),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a gender.';
        }
        return null;
      },
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedGender = value;
          });
        }
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.strokColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Text(
              DateFormat('d/MM/yyyy').format(selectedDate),
              style: CustomResponsiveTextStyles.fieldText1,
            ),
          ],
        ),
      ),
    );
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
