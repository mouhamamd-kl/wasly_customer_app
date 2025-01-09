import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasly_template/core/widgets/text/text_heading_7.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                child: Row(
                  children: [
                    // User Profile Image
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        AppConstants.getIconPath("drawer/user_icon.svg"),
                      ), // Replace with your image
                    ),
                    const SizedBox(width: 10),
                    // User Name and Email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextHeading7(
                            text: 'Robert Downey',
                            textAlign: TextAlign.start,
                          ),
                          const TextParagraph4(
                            text: 'ulhut@gmail.com',
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
                      () {},
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
                      () {},
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
