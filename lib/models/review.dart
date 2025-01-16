import 'rating.dart';
import 'product.dart';
import 'customer.dart';

class Review {
  final int id;
  final Rating? rating; // Nullable because it's conditionally loaded
  final Product? product; // Nullable because it's conditionally loaded
  final Customer? customer; // Nullable because it's conditionally loaded
  final String? description; // Nullable if description might not exist
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    this.rating,
    this.product,
    this.customer,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating?.toJson(),
      'product': product?.toJson(),
      'customer': customer?.toJson(),
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
