import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/category.dart';
import 'package:wasly/models/product.dart';

class CategoryService {
  final ApiService _apiService = ApiService();

  /// Fetch all categories
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiService.get('/category');
      if (response.statusCode == 200) {
        final List categories = jsonDecode(response.body)['data'];
        return categories.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  /// Fetch products in a specific category
  Future<List<Product>> getCategoryProducts(int categoryId) async {
    try {
      final response = await _apiService.get('/category/$categoryId/products');
      if (response.statusCode == 200) {
        final List products = jsonDecode(response.body)['data'];
        return products.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch category products');
      }
    } catch (e) {
      throw Exception('Error fetching category products: $e');
    }
  }
}
