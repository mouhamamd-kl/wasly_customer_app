import 'package:wasly/core/helper.dart';

import 'category.dart';
import 'store.dart';

class Product {
  final int id;
  final String name;
  final String photo;
  final String description;
  final int stockQuantity;
  final double price;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category? category; // Nullable because it's loaded conditionally
  final Store? store; // Nullable because it's loaded conditionally
  final double? averageRating;
  Product({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.stockQuantity,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.store,
    this.averageRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      description: json['description'],
      stockQuantity: json['stock_quantity'],
      price: double.tryParse(json['price'])!,
      averageRating: 5.0,
      isActive: Helper.intToBool(json['is_active']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      category: Category.fromJson(json['category']),
      store: Store.fromJson(json['store']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'description': description,
      'stock_quantity': stockQuantity,
      'price': price,
      'average_rating': averageRating,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category': category?.toJson(),
      'store': store?.toJson(),
    };
  }
}
