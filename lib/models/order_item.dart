import 'order.dart';
import 'product.dart';
import 'order_status.dart';

class OrderItem {
  final int id;
  final Order? order; // Nullable because it's conditionally loaded
  final Product? product; // Nullable because it's conditionally loaded
  final OrderStatus? orderStatus; // Nullable because it's conditionally loaded
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItem({
    required this.id,
    this.order,
    this.product,
    this.orderStatus,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create an `OrderItem` from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      orderStatus: json['order_status'] != null
          ? OrderStatus.fromJson(json['order_status'])
          : null,
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `OrderItem` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order?.toJson(),
      'product': product?.toJson(),
      'order_status': orderStatus?.toJson(),
      'quantity': quantity,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
