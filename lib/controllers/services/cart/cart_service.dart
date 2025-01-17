import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/cart_product.dart';

class CartService {
  final ApiService _apiService = ApiService();

  /// Add a product to the cart
  Future<void> addToCart(int productId, int count) async {
    try {
      final response = await _apiService.post('/cart/add', data: {
        'product_id': productId,
        'count': count,
      });

      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ??
            'Failed to add product to cart';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to add product to cart: $e');
    }
  }

  /// Remove a product from the cart
  Future<void> removeFromCart(int productId) async {
    try {
      final response = await _apiService.delete('/cart/$productId');

      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ??
            'Failed to remove product from cart';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to remove product from cart: $e');
    }
  }

  /// Clear all products from the cart
  Future<void> clearCart() async {
    try {
      final response = await _apiService.post('/cart/clear');

      if (response.statusCode != 200) {
        final message =
            jsonDecode(response.body)['message'] ?? 'Failed to clear cart';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  /// Fetch cart products for the user
  Future<Map<String, dynamic>> getCartProducts() async {
    try {
      final response = await _apiService.get('/cart/products');

      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ??
            'Failed to fetch cart products';
        throw Exception(message);
      }

      final data = jsonDecode(response.body)['data'];

      final total = data['total'];

      return {'products': data['data'], 'total': total};
    } catch (e) {
      throw Exception('Failed to fetch cart products: $e');
    }
  }
}
