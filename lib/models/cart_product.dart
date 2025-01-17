import 'product.dart';

class CartProduct {
  final Product product;
  final int count;
  final double subtotal;

  CartProduct({
    required this.product,
    required this.count,
    required this.subtotal,
  });

  /// Factory method to create a `CartProduct` from JSON
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      product: Product.fromJson(json['product']),
      count: int.tryParse(json['count'])!,
      subtotal: json['subtotal'],
    );
  }

  /// Convert `CartProduct` to JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'count': count,
      'subtotal': subtotal,
    };
  }
}
