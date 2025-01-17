// import 'package:flutter/material.dart';
// import 'package:wasly/widgets/favorutite_product_card.dart';

// class FavouriteProductGridview extends StatelessWidget {
//   final List<Map<String, String>> products;

//   const FavouriteProductGridview({
//     Key? key,
//     required this.products,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Number of columns
//           crossAxisSpacing: 16, // Space between columns
//           mainAxisSpacing: 16, // Space between rows
//           childAspectRatio: 1, // Adjust the aspect ratio as needed
//         ),
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return FavorutiteProductCard(
//             name: product["name"]!,
//             imagePath: product["image"]!,
//           );
//         },
//       ),
//     );
//   }
// }
