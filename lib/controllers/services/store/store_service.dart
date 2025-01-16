import 'dart:convert';
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/product.dart';
import 'package:wasly/models/store.dart';

class StoreService {
  final ApiService _apiService = ApiService();

  /// Fetch all stores
  Future<List<Store>> getAllStores() async {
    final response = await _apiService.get('/store');
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Store.fromJson(json)).toList();
  }

  /// Get a single store by ID
  Future<Store> getStoreById(int storeId) async {
    final response = await _apiService.get('/store/$storeId');
    final data = jsonDecode(response.body)['data'];
    return Store.fromJson(data);
  }

  /// Search for stores by name
  Future<List<Store>> searchStores(String name) async {
    final response = await _apiService.get('/store/search?name=$name');
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Store.fromJson(json)).toList();
  }

  /// Fetch the latest stores
  Future<List<Store>> getLatestStores() async {
    final response = await _apiService.get('/store/latest');
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Store.fromJson(json)).toList();
  }

  /// Fetch nearby stores
  Future<List<Store>> getNearbyStores(double latitude, double longitude,
      {int radius = 10, int limit = 10}) async {
    final response = await _apiService.get(
      '/store/nearby?latitude=$latitude&longitude=$longitude&radius=$radius&limit=$limit',
    );
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Store.fromJson(json)).toList();
  }

  /// Fetch popular stores by orders
  Future<List<Store>> getPopularStoresByOrders() async {
    final response = await _apiService.get('/store/popular/orders');
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Store.fromJson(json)).toList();
  }

  /// Fetch popular stores by ratings
  Future<List<Store>> getPopularStoresByRatings() async {
    final response = await _apiService.get('/store/popular/ratings');
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Store.fromJson(json)).toList();
  }

  /// Create a new store (requires authentication)
  Future<void> createStore(Map<String, dynamic> storeData) async {
    await _apiService.post('/store', data: storeData);
  }

  /// Update an existing store (requires authentication)
  Future<void> updateStore(int storeId, Map<String, dynamic> storeData) async {
    await _apiService.put('/store/$storeId', data: storeData);
  }

  /// Delete a store (requires authentication)
  Future<void> deleteStore(int storeId) async {
    await _apiService.delete('/store/$storeId');
  }

  /// Get products for a specific store
  Future<List<Product>> getStoreProducts(int storeId) async {
    final response = await _apiService.get('/store/$storeId/products');
    final data = jsonDecode(response.body)['data'] as List;
    return data.map((json) => Product.fromJson(json)).toList();
  }
}
