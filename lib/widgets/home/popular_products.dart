// import 'package:flutter/material.dart';
// import 'package:wasly/controllers/services/product/product_service.dart';
// import 'package:wasly/models/product.dart';
// import 'package:wasly_template/core/widgets/card/product_card_container.dart';

// class PopularProductsWidget extends StatefulWidget {
//   const PopularProductsWidget({Key? key}) : super(key: key);

//   @override
//   State<PopularProductsWidget> createState() => _PopularProductsWidgetState();
// }

// class _PopularProductsWidgetState extends State<PopularProductsWidget> {
//   final ProductService _productService = ProductService();
//   late Future<List<Product>> _popularProductsFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch popular products when the widget is initialized
//     _popularProductsFuture = _productService.getPopularProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 215,
//       child: FutureBuilder<List<Product>>(
//         future: _popularProductsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No popular products found.'));
//           }

//           final products = snapshot.data!;

//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return Row(
//                 children: [
//                   ProductCardContainer(
//                     imagePath:
//                         product.photo ?? "assets/default_product_image.png",
//                     productName: product.name,
//                     rate: product.averageRating ??
//                         0.0, // Assuming `averageRating` is nullable
//                     numberOfRating: product.averageRating!.toInt() ??
//                         0, // Assuming `numberOfReviews` is in your model
//                     tags: product.category?.name ?? "Unknown",
//                     deliveryTime: "N/A",
//                   ),
//                   if (index < products.length - 1) const SizedBox(width: 16.0),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:wasly/controllers/services/product/product_service.dart';
import 'package:wasly/models/product.dart';
import 'package:wasly/screens/bayer/product_details.dart';
import 'package:wasly_template/core/widgets/card/product_card_container.dart';

class PopularProductsWidget extends StatefulWidget {
  const PopularProductsWidget({Key? key}) : super(key: key);

  @override
  State<PopularProductsWidget> createState() => _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends State<PopularProductsWidget> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _popularProductsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch popular products when the widget is initialized
    _popularProductsFuture = _productService.getPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 215,
      child: FutureBuilder<List<Product>>(
        future: _popularProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No popular products found.'));
          }
          final products = snapshot.data!;
          print(products);

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(productId: product.id),
                        ),
                      );
                    },
                    child: ProductCardContainer(
                      imagePath:
                          product.photo ?? "assets/default_product_image.png",
                      productName: product.name,
                      rate: product.averageRating ??
                          0.0, // Assuming `averageRating` is nullable
                      numberOfRating: product.averageRating!.toInt() ??
                          0, // Assuming `numberOfReviews` is in your model
                      tags: product.category?.name ?? "Unknown",
                      deliveryTime: "N/A",
                    ),
                  ),
                  if (index < products.length - 1) const SizedBox(width: 16.0),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
