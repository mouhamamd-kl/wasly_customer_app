import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/order_item.dart';

class OrderService {
  final ApiService _apiService = ApiService();

  /// Create a new order
  Future<void> createOrder({
    required int deliveryId,
    required int paymentMethodId,
  }) async {
    try {
      final response = await _apiService.post('/order/orders', data: {
        'delivery_id': deliveryId,
        'payment_method_id': paymentMethodId,
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  /// Process payment for an order item
  Future<void> processPayment({
    required int orderItemId,
    required int paymentMethodId,
    String? cardId,
  }) async {
    try {
      final response = await _apiService
          .post('/order/orders/items/$orderItemId/payment', data: {
        'payment_method_id': paymentMethodId,
        'card_id': cardId,
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to process payment');
      }
    } catch (e) {
      throw Exception('Error processing payment: $e');
    }
  }

  /// Cancel an order item
  Future<void> cancelOrderItem(int orderItemId) async {
    try {
      final response =
          await _apiService.post('/order/orders/items/$orderItemId/cancel');

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel order item');
      }
    } catch (e) {
      throw Exception('Error cancelling order item: $e');
    }
  }

  /// Get all orders for the authenticated user
  Future<List<OrderItem>> getUserOrderItems() async {
    try {
      final response = await _apiService.get('/order/orders/items');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['data'];
        return data.map((json) => OrderItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch order items');
      }
    } catch (e) {
      throw Exception('Error fetching order items: $e');
    }
  }

  /// Update the status of an order item (Store owner only)
  Future<void> updateOrderItemStatus({
    required int orderItemId,
    required String status,
  }) async {
    try {
      final response = await _apiService
          .post('/order/orders/items/$orderItemId/status', data: {
        'status': status,
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to update order item status');
      }
    } catch (e) {
      throw Exception('Error updating order item status: $e');
    }
  }
}
