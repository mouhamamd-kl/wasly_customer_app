import 'package:flutter/material.dart';
import 'package:wasly/controllers/services/product/product_service.dart';
import 'package:wasly/models/product.dart';
import 'package:wasly_template/core/widgets/card/product_card_container.dart';

class LatestProductsWidget extends StatefulWidget {
  const LatestProductsWidget({Key? key}) : super(key: key);

  @override
  State<LatestProductsWidget> createState() => _LatestProductsWidgetState();
}

class _LatestProductsWidgetState extends State<LatestProductsWidget> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _latestProductsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the latest products when the widget is initialized
    _latestProductsFuture = _productService.getLatestProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 215,
      child: FutureBuilder<List<Product>>(
        future: _latestProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No latest products found.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Row(
                children: [
                  ProductCardContainer(
                    imagePath: product.photo,
                    productName: product.name,
                    rate: product.averageRating ??
                        0.0, // Assuming `averageRating` is nullable
                    numberOfRating: product.averageRating!.toInt() ??
                        0, // Assuming `numberOfReviews` exists in your model
                    tags: product.category?.name ?? "Unknown",
                    deliveryTime: "N/A",
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
