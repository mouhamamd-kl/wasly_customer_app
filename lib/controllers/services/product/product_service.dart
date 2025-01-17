import 'dart:convert';
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/product.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  /// Fetch all products
  Future<List<Product>> getAllProducts() async {
    final response = await _apiService.get('/product');
    final List products = jsonDecode(response.body)['data'];
    return products.map((json) => Product.fromJson(json)).toList();
  }

  /// Fetch latest products
  Future<List<Product>> getLatestProducts() async {
    final response = await _apiService.get('/product/latest');
    final List products = jsonDecode(response.body)['data'];
    return products.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> getPopularProducts() async {
    final response = await _apiService.get('/product/popular');
    final List products = jsonDecode(response.body)['data'];
    print(products);
    return products.map((json) => Product.fromJson(json)).toList();
  }

  /// Search for products
  Future<List<Product>> searchProducts(Map<String, dynamic> filters) async {
    final response = await _apiService.post('/product/search', data: filters);
    final List products = jsonDecode(response.body)['data'];
    return products.map((json) => Product.fromJson(json)).toList();
  }

  /// Get a single product by ID
  Future<Product> getProductById(int id) async {
    final response = await _apiService.get('/product/$id');
    return Product.fromJson(jsonDecode(response.body)['data']);
  }

  /// Create a new product
  Future<void> createProduct(Map<String, dynamic> productData) async {
    await _apiService.post('/product', data: productData);
  }

  /// Update an existing product
  Future<void> updateProduct(int id, Map<String, dynamic> productData) async {
    await _apiService.put('/product/$id', data: productData);
  }

  /// Delete a product
  Future<void> deleteProduct(int id) async {
    await _apiService.delete('/product/$id');
  }
}
