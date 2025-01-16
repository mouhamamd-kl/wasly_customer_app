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
  // Sample product data
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Wireless Headphones',
      'imageUrl': 'https://i.imgur.com/0D1AgqE.png',
      'price': 99.99,
      'itemCount': 1,
      'status': 'pending',
      'rate': 4.5,
      'numberOfRating': 128
    },
    {
      'name': 'Smart Watch',
      'imageUrl': 'https://i.imgur.com/0D1AgqE.png',
      'price': 199.99,
      'itemCount': 2,
      'status': 'delivered',
      'rate': 4.8,
      'numberOfRating': 256
    },
    {
      'name': 'Bluetooth Speaker',
      'imageUrl': 'https://i.imgur.com/0D1AgqE.png',
      'price': 79.99,
      'itemCount': 1,
      'status': 'pending',
      'rate': 4.2,
      'numberOfRating': 89
    },
    // Add more products as needed
  ];

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
          spacing: 20,
          children: [
            CustomSearchField(
              fillColor: Color(0xfff8fafc),
              controller: _searchController,
              hintText: "Search Order Products",
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
            ),
            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ExpandingProductCard(
                    name: product['name'],
                    imageUrl: product['imageUrl'],
                    price: product['price'],
                    itemCount: product['itemCount'],
                    status: product['status'],
                    rate: product['rate'],
                    numberOfRating: product['numberOfRating'],
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
