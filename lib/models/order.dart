import 'store.dart';
import 'customer.dart';
import 'delivery.dart';
import 'order_status.dart';

class Order {
  final int id;
  final Store? store; // Nullable because it's conditionally loaded
  final Customer? customer; // Nullable because it's conditionally loaded
  final Delivery? delivery; // Nullable because it's conditionally loaded
  final OrderStatus? orderStatus; // Nullable because it's conditionally loaded
  final DateTime? orderPlacedAt; // Nullable
  final DateTime? orderDeliveredAt; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    this.store,
    this.customer,
    this.delivery,
    this.orderStatus,
    this.orderPlacedAt,
    this.orderDeliveredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create an `Order` from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      delivery:
          json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null,
      orderStatus: json['order_status'] != null
          ? OrderStatus.fromJson(json['order_status'])
          : null,
      orderPlacedAt: json['order_placed_at'] != null
          ? DateTime.parse(json['order_placed_at'])
          : null,
      orderDeliveredAt: json['order_delivered_at'] != null
          ? DateTime.parse(json['order_delivered_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `Order` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store': store?.toJson(),
      'customer': customer?.toJson(),
      'delivery': delivery?.toJson(),
      'order_status': orderStatus?.toJson(),
      'order_placed_at': orderPlacedAt?.toIso8601String(),
      'order_delivered_at': orderDeliveredAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
