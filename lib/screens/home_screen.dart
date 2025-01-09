import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly/core/test_data/testData.dart';
import 'package:wasly/main.dart';
import 'package:wasly/widgets/chip_list.dart';
import 'package:wasly/widgets/custom_drawer.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/core/widgets/card/product_card_container.dart';
import 'package:wasly_template/core/widgets/general/price_range_slider.dart';
import 'package:wasly_template/core/widgets/text/text_heading_7.dart';
import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
import 'package:wasly_template/core/widgets/text/text_paragraph_4.dart';
import 'package:wasly_template/wasly_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final controller = Get.find<NavController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu), // Drawer icon
          onPressed: () {
            // Open the drawer when the icon is pressed
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensures the Row takes minimum width
              children: [
                Text(
                  "LOCATION",
                  style: CustomResponsiveTextStyles.fieldText3
                      .copyWith(color: AppColors.primaryBase),
                ),
                const SizedBox(width: 5), // Add spacing between text and arrow
                SvgPicture.asset(
                  AppConstants.getIconPath("arrow_down.svg"),
                  height: 10, // Adjust icon size as needed
                ),
              ],
            ),
            const TextHeading9(text: "46 Larkrow, London"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              size: 44,
            ), // User icon
            onPressed: () {
              // Handle user icon action
            },
          ),
        ],
      ),
      drawer: CustomDrawer(), // Attach the CustomDrawer
      bottomNavigationBar: Obx(
        () => CustomBottomNavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onTap: controller.updateIndex,
          items: bottomNavItems,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              spacing: 30,
              children: [
                CustomSearchField(
                  fillColor: Color(0xfff8fafc),
                  controller: _searchController,
                  hintText: "Search Products and Stores",
                  border: CustomOutlineInputBorder.defaultBorder(
                    borderRadius: 100,
                    borderColor: AppColors.backgroundAccent,
                  ),
                  suffix: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                spacing: 20,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      spacing: 20,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextHeading9(
                                          text: "Categories",
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: ChipList(
                                            list: categories,
                                            onCategorySelected: (category) {
                                              print(
                                                  'Selected category: $category');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      spacing: 20,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextHeading9(
                                          text: "Sort By",
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: ChipList(
                                            list: sort,
                                            onCategorySelected: (category) {
                                              print(
                                                  'Selected category: $category');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      spacing: 20,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextHeading9(
                                          text: "Price Range",
                                          textAlign: TextAlign.start,
                                        ),
                                        PriceRangeSlider(
                                          min: 0,
                                          max: 1000,
                                          initialValues:
                                              const RangeValues(200, 800),
                                          onChanged: (values) {
                                            // Handle the range changes here
                                            print(
                                                'Min: \$${values.start.toStringAsFixed(0)}, Max: \$${values.end.toStringAsFixed(0)}');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors
                              .surfaceLight, // Set the background color
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
                  ),
                  prefix: SvgPicture.asset(
                    AppConstants.getIconPath("search.svg"),
                    height: 16,
                    width: 16,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Container(
                  height: 50,
                  child: ChipList(
                    list: categories,
                    onCategorySelected: (category) {
                      // Handle category selection
                      print('Selected category: $category');
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 0),
                          child: Text(
                            "Near Stores",
                            style: CustomResponsiveTextStyles.buttonText2
                                .copyWith(color: AppColors.textPrimaryBase),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Text(
                                "View All",
                                style: CustomResponsiveTextStyles.buttonText2
                                    .copyWith(
                                  color: AppColors.primaryBase,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SmallCardContainer(
                                  description: "this is the test description",
                                  imagePath: AppConstants.getMockUpPath(
                                      "product_image.png"),
                                  name: "al fathon".toUpperCase()),
                              if (index <
                                  19) // Add space only between items, not after the last item
                                const SizedBox(width: 16.0),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 0),
                          child: Text(
                            "Popular Products",
                            style: CustomResponsiveTextStyles.buttonText2
                                .copyWith(color: AppColors.textPrimaryBase),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Text(
                                "View All",
                                style: CustomResponsiveTextStyles.buttonText2
                                    .copyWith(
                                  color: AppColors.primaryBase,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 215,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              ProductCardContainer(
                                imagePath: AppConstants.getMockUpPath(
                                    "product_image.png"),
                                productName: "Nike Air Mar",
                                rate: 5.0,
                                numberOfRating: 200,
                                tags: "hele wef",
                                deliveryTime: "20",
                              ),
                              if (index <
                                  19) // Add space only between items, not after the last item
                                const SizedBox(width: 16.0),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 0),
                          child: Text(
                            "Latest Products",
                            style: CustomResponsiveTextStyles.buttonText2
                                .copyWith(color: AppColors.textPrimaryBase),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Text(
                                "View All",
                                style: CustomResponsiveTextStyles.buttonText2
                                    .copyWith(
                                  color: AppColors.primaryBase,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 215,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              ProductCardContainer(
                                imagePath: AppConstants.getMockUpPath(
                                    "product_image.png"),
                                productName: "Nike Air Mar",
                                rate: 5.0,
                                numberOfRating: 200,
                                tags: "hele wef",
                                deliveryTime: "20",
                              ),
                              if (index <
                                  19) // Add space only between items, not after the last item
                                const SizedBox(width: 16.0),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
