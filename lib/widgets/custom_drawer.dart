import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/services/auth/customer_auth_service.dart';
import 'package:wasly/models/customer.dart';
import 'package:wasly/screens/delivery/delivery_history_screen.dart';
import 'package:wasly/screens/profile/edit_profile_screen.dart';
import 'package:wasly_template/core/widgets/text/text_heading_7.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final CustomerAuthService _authService = CustomerAuthService();

  Future<Customer>? _customerFuture;

  @override
  void initState() {
    super.initState();
    // Fetch customer info on widget load
    _customerFuture = _authService.getCustomerInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User Profile Section
              Container(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<Customer>(
                  future: _customerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading state while fetching the customer data
                      return const CircleAvatar(
                        radius: 30,
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      // Show an error state if fetching fails
                      return CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.error, color: Colors.red),
                      );
                    } else if (snapshot.hasData) {
                      // Show the fetched customer data
                      final customer = snapshot.data!;
                      print(customer.toJson());
                      return Row(
                        children: [
                          // User Profile Image
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(customer.photo!),
                          ),
                          const SizedBox(width: 10),
                          // User Name and Email
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextHeading7(
                                  text: customer.firstName,
                                  textAlign: TextAlign.start,
                                ),
                                TextParagraph4(
                                  text: customer.email,
                                ),
                              ],
                            ),
                          ),
                          // Close Button
                          IconButton(
                            icon: SvgPicture.asset(
                              AppConstants.getIconPath("arrow_down.svg"),
                              height: 10, // Adjust icon size as needed
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                        ],
                      );
                    } else {
                      // Fallback for unexpected states
                      return const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      );
                    }
                  },
                ),
              ),
              // Menu Items Section
              Expanded(
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDrawerItem(
                      SvgPicture.asset(
                        AppConstants.getIconPath("drawer/profile.svg"),
                      ),
                      'Edit Profile',
                      () {
                        Get.to(EditProfileScreen());
                      },
                    ),
                    _buildDrawerItem(
                      SvgPicture.asset(
                        AppConstants.getIconPath("drawer/wallet.svg"),
                      ),
                      'Payment Method',
                      () {},
                    ),
                    _buildDrawerItem(
                      SvgPicture.asset(
                        AppConstants.getIconPath("drawer/message.svg"),
                      ),
                      'Contact Us',
                      () {},
                    ),
                    _buildDrawerItem(
                      SvgPicture.asset(
                        AppConstants.getIconPath("drawer/setting.svg"),
                      ),
                      'Settings',
                      () {},
                    ),
                    _buildDrawerItem(
                      SvgPicture.asset(
                        AppConstants.getIconPath("drawer/calender.svg"),
                      ),
                      'Delivery History',
                      () {
                        Get.to(DeliveryHistoryPage());
                      },
                    ),
                    _buildDrawerItem(
                      SvgPicture.asset(
                        AppConstants.getIconPath("drawer/faq.svg"),
                      ),
                      'FAQ',
                      () {},
                    ),
                  ],
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primaryBase,
                      child: SvgPicture.asset(
                        AppConstants.getIconPath("drawer/app_icon.svg"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const TextHeading4(
                      text: "WASLY",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer Item Builder
  Widget _buildDrawerItem(SvgPicture icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: icon,
      title: TextHeading9(
        text: title,
        textAlign: TextAlign.start,
      ),
      onTap: onTap,
    );
  }
}
