import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/wasly_template.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final controller = Get.find<NavController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        title: Text("order Screen"),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onTap: controller.updateIndex,
          items: bottomNavItems,
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          spacing: 50,
          children: [
            // CustomSearchField(
            //   fillColor: Color(0xfff8fafc),
            //   controller: _searchController,
            //   hintText: "Search Products and Stores",
            //   border: CustomOutlineInputBorder.defaultBorder(
            //     borderRadius: 100,
            //     borderColor: AppColors.backgroundAccent,
            //   ),
            //   suffix: Container(
            //     // decoration: BoxDecoration(
            //     //   color: AppColors.surfaceLight,
            //     //   borderRadius: BorderRadius.circular(50),
            //     // ),
            //     // padding: EdgeInsets.all(10),
            //     child: SvgPicture.asset(
            //       AppConstants.getIconPath("filter.svg"),

            //       height: 16,
            //       width: 16,
            //       fit: BoxFit.scaleDown,
            //     ),
            //   ),
            //   prefix: SvgPicture.asset(
            //     AppConstants.getIconPath(
            //       "search.svg",
            //     ),
            //     height: 16,
            //     width: 16,
            //     fit: BoxFit.scaleDown,
            //   ),
            // )
            CustomSearchField(
              fillColor: Color(0xfff8fafc),
              controller: _searchController,
              hintText: "Search Products and Stores",
              border: CustomOutlineInputBorder.defaultBorder(
                borderRadius: 100,
                borderColor: AppColors.backgroundAccent,
              ),
              suffix: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight, // Set the background color
                    shape: BoxShape.circle, // Make it round
                  ),
                  // Adjust the padding to control the size of the circle
                  child: SvgPicture.asset(
                    AppConstants.getIconPath("filter.svg"),
                    height: 16,
                    width: 16,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              prefix: SvgPicture.asset(
                AppConstants.getIconPath("search.svg"),
                height: 16,
                width: 16,
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
      )),
    );
  }
}
