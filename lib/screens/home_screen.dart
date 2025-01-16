import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/controllers/services/category/category_service.dart';
import 'package:wasly/controllers/services/store/store_service.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly/models/category.dart';
import 'package:wasly/widgets/chip_list.dart';
import 'package:wasly/widgets/custom_drawer.dart';
import 'package:wasly/widgets/home/latest_product.dart';
import 'package:wasly/widgets/home/nearby_store.dart';
import 'package:wasly/widgets/home/popular_products.dart';
import 'package:wasly/widgets/home/section.dart';
import 'package:wasly/widgets/search/search_widget.dart';

import 'package:wasly_template/core/widgets/text/text_heading_9.dart';
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
  late Future<List<Category>> _categoriesFuture;
  final storeService = StoreService();
  Category? selectedCategory;
  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().getCategories();
  }

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
                SearchFilterWidget(
                  onSearchTap: () {},
                  categoriesFuture: CategoryService().getCategories(),
                  onFilterApplied:
                      (searchText, selectedCategory, sortOption, priceRange) {
                    print("Search Text: $searchText");
                    print("Selected Category: $selectedCategory");
                    print("Sort Option: $sortOption");
                    print(
                        "Price Range: ${priceRange.start} - ${priceRange.end}");
                  },
                ),
                Container(
                  height: 50,
                  child: getCategories(categoriesFuture: _categoriesFuture),
                ),
                Section(
                  sectionTitle: "Near Stores",
                  actionText: "view All",
                  onActionTap: () {},
                  child: NearbyStoresWidget(latitude: 100, longitude: 100),
                ),
                Section(
                  sectionTitle: "Popular Products",
                  actionText: "view All",
                  onActionTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 215,
                    child: PopularProductsWidget(),
                  ),
                ),
                Section(
                  sectionTitle: "Latest Products",
                  actionText: "view All",
                  onActionTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 215,
                    child: LatestProductsWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class getCategories extends StatelessWidget {
  const getCategories({
    super.key,
    required Future<List<Category>> categoriesFuture,
  }) : _categoriesFuture = categoriesFuture;

  final Future<List<Category>> _categoriesFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No categories available'));
        }

        final categories = snapshot.data!;

        return ChipList(
          list: categories,
          onCategorySelected: (selectedCategory) {
            print('Selected category: $selectedCategory');
          },
        );
      },
    );
  }
}


 // CustomSearchField(
                //   fillColor: Color(0xfff8fafc),
                //   controller: _searchController,
                //   hintText: "Search Products and Stores",
                //   border: CustomOutlineInputBorder.defaultBorder(
                //     borderRadius: 100,
                //     borderColor: AppColors.backgroundAccent,
                //   ),
                //   suffix: GestureDetector(
                //     onTap: () {
                //       Get.bottomSheet(
                //         SingleChildScrollView(
                //           child: Container(
                //             width: double.infinity,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(30),
                //                 topRight: Radius.circular(30),
                //               ),
                //             ),
                //             child: Padding(
                //               padding: EdgeInsets.all(30),
                //               child: Column(
                //                 spacing: 20,
                //                 children: <Widget>[
                //                   Container(
                //                     width: double.infinity,
                //                     child: Column(
                //                       spacing: 20,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                         TextHeading9(
                //                           text: "Categories",
                //                           textAlign: TextAlign.start,
                //                         ),
                //                         SizedBox(
                //                           height: 50,
                //                           child: getCategories(
                //                             categoriesFuture: _categoriesFuture,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   Container(
                //                     width: double.infinity,
                //                     child: Column(
                //                       spacing: 20,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                         TextHeading9(
                //                           text: "Sort By",
                //                           textAlign: TextAlign.start,
                //                         ),
                //                         SizedBox(
                //                           height: 50,
                //                           child: SortList(
                //                             list: sort,
                //                             onCategorySelected: (category) {
                //                               print('Selected sort: $category');
                //                             },
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   Container(
                //                     width: double.infinity,
                //                     child: Column(
                //                       spacing: 20,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                         TextHeading9(
                //                           text: "Price Range",
                //                           textAlign: TextAlign.start,
                //                         ),
                //                         PriceRangeSlider(
                //                           min: 0,
                //                           max: 1000,
                //                           initialValues:
                //                               const RangeValues(200, 800),
                //                           onChanged: (values) {
                //                             // Handle the range changes here
                //                             print(
                //                                 'Min: \$${values.start.toStringAsFixed(0)}, Max: \$${values.end.toStringAsFixed(0)}');
                //                           },
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Container(
                //         decoration: BoxDecoration(
                //           color: AppColors
                //               .surfaceLight, // Set the background color
                //           shape: BoxShape.circle, // Make it round
                //         ),
                //         // Adjust the padding to control the size of the circle
                //         child: SvgPicture.asset(
                //           AppConstants.getIconPath("filter.svg"),
                //           height: 16,
                //           width: 16,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //   ),
                //   prefix: SvgPicture.asset(
                //     AppConstants.getIconPath("search.svg"),
                //     height: 16,
                //     width: 16,
                //     fit: BoxFit.scaleDown,
                //   ),
                // ),