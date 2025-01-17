// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:wasly/controllers/nav_controller.dart';
// import 'package:wasly/core/constant_widgets/navigation_bar.dart';
// import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
// import 'package:wasly_template/wasly_template.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   // Create a GlobalKey for the Scaffold
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _searchController = TextEditingController();
//   final controller = Get.find<NavController>();
//   // Sample product data
//   final List<Map<String, dynamic>> products = [
//     {
//       'name': 'Wireless Headphones',
//       'imageUrl': 'https://i.imgur.com/0D1AgqE.png',
//       'price': 99.99,
//       'itemCount': 1,
//       'status': 'pending',
//       'rate': 4.5,
//       'numberOfRating': 128
//     },
//     {
//       'name': 'Smart Watch',
//       'imageUrl': 'https://i.imgur.com/0D1AgqE.png',
//       'price': 199.99,
//       'itemCount': 2,
//       'status': 'delivered',
//       'rate': 4.8,
//       'numberOfRating': 256
//     },
//     {
//       'name': 'Bluetooth Speaker',
//       'imageUrl': 'https://i.imgur.com/0D1AgqE.png',
//       'price': 79.99,
//       'itemCount': 1,
//       'status': 'pending',
//       'rate': 4.2,
//       'numberOfRating': 89
//     },
//     // Add more products as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey, // Assign the key to the Scaffold
//       appBar: AppBar(
//         title: Text("order Screen"),
//       ),
//       bottomNavigationBar: Obx(
//         () => CustomBottomNavigationBar(
//           selectedIndex: controller.selectedIndex.value,
//           onTap: controller.updateIndex,
//           items: bottomNavItems,
//         ),
//       ),
//       body: SafeArea(
//           child: Container(
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(color: Colors.white),
//         child: Column(
//           spacing: 20,
//           children: [
//             CustomSearchField(
//               fillColor: Color(0xfff8fafc),
//               controller: _searchController,
//               hintText: "Search Order Products",
//               border: CustomOutlineInputBorder.defaultBorder(
//                 borderRadius: 100,
//                 borderColor: AppColors.backgroundAccent,
//               ),
//               suffix: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.surfaceLight, // Set the background color
//                     shape: BoxShape.circle, // Make it round
//                   ),
//                   // Adjust the padding to control the size of the circle
//                   child: SvgPicture.asset(
//                     AppConstants.getIconPath("filter.svg"),
//                     height: 16,
//                     width: 16,
//                     fit: BoxFit.scaleDown,
//                   ),
//                 ),
//               ),
//               prefix: SvgPicture.asset(
//                 AppConstants.getIconPath("search.svg"),
//                 height: 16,
//                 width: 16,
//                 fit: BoxFit.scaleDown,
//               ),
//             ),
//             // Product List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ExpandingProductCard(
//                     name: product['name'],
//                     imageUrl: product['imageUrl'],
//                     price: product['price'],
//                     itemCount: product['itemCount'],
//                     status: product['status'],
//                     rate: product['rate'],
//                     numberOfRating: product['numberOfRating'],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wasly/controllers/nav_controller.dart';
import 'package:wasly/controllers/services/category/category_service.dart';
import 'package:wasly/controllers/services/order/order_service.dart';
import 'package:wasly/core/constant_widgets/navigation_bar.dart';
import 'package:wasly/models/order_item.dart';
import 'package:wasly/screens/bayer/product_details.dart';
import 'package:wasly/widgets/search/search_widget.dart';
import 'package:wasly_template/core/widgets/Border/custom_outline_input_border.dart';
import 'package:wasly_template/wasly_template.dart'; // Adjust the import path as needed
import 'dart:convert'; // For JSON decoding

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
  final OrderService orderService = OrderService(); // Service instance
  late Future<List<OrderItem>> _orderItems; // Future to hold fetched data

  @override
  void initState() {
    super.initState();
    _orderItems = orderService.getUserOrderItems(); // Fetch data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        title: Text("Order Screen"),
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
            children: [
              SearchFilterWidget(
                onSearchTap: () {},
                categoriesFuture: CategoryService().getCategories(),
                onFilterApplied:
                    (searchText, selectedCategory, sortOption, priceRange) {
                  print("Search Text: $searchText");
                  print("Selected Category: $selectedCategory");
                  print("Sort Option: $sortOption");
                  print("Price Range: ${priceRange.start} - ${priceRange.end}");
                },
              ),
              SizedBox(height: 20), // Add some spacing
              Expanded(
                child: FutureBuilder<List<OrderItem>>(
                  future: _orderItems,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No orders found."));
                    } else {
                      final orders = snapshot.data!;
                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return ExpandingProductCard(
                            onDoubleTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetails(
                                      productId: order.product!.id,
                                    );
                                  },
                                ),
                              );
                            },
                            name: order.product!.name, // Assuming `name` exists
                            imageUrl: order
                                .product!.photo, // Assuming `imageUrl` exists
                            price: order.price, // Assuming `price` exists
                            itemCount:
                                order.quantity, // Assuming `itemCount` exists
                            status: order
                                .orderStatus!.name, // Assuming `status` exists
                            rate: order.product!
                                .averageRating!, // Assuming `rate` exists
                            numberOfRating:
                                100, // Assuming `numberOfRating` exists
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
