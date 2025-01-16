import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/product.dart';

class FavouriteService {
  final ApiService _apiService = ApiService();

  /// Add a product to favourites
  Future<void> addToFavourites(int productId) async {
    try {
      final response =
          await _apiService.post('/customer/favourites/add/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to add product to favourites');
      }
    } catch (e) {
      throw Exception('Error adding to favourites: $e');
    }
  }

  /// Remove a product from favourites
  Future<void> removeFromFavourites(int productId) async {
    try {
      final response =
          await _apiService.delete('/customer/favourites/remove/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to remove product from favourites');
      }
    } catch (e) {
      throw Exception('Error removing from favourites: $e');
    }
  }

  /// Get all favourite products of the authenticated user
  Future<List<Product>> getUserFavouriteProducts() async {
    try {
      final response = await _apiService.get('/customer/favourites/list');
      if (response.statusCode == 200) {
        final List products = jsonDecode(response.body)['data'];
        return products.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch favourite products');
      }
    } catch (e) {
      throw Exception('Error fetching favourite products: $e');
    }
  }

  /// Clear all favourite products for the authenticated user
  Future<void> clearUserFavouriteProducts() async {
    try {
      final response = await _apiService.post('/customer/favourites/clear');
      if (response.statusCode != 200) {
        throw Exception('Failed to clear favourite products');
      }
    } catch (e) {
      throw Exception('Error clearing favourite products: $e');
    }
  }
}
