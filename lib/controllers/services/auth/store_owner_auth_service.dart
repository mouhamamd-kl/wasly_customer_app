import 'dart:convert';
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/customer.dart';
import 'package:wasly/models/store_owner.dart';
import '../storage/secure_storage_service.dart';

class StoreOwnerAuthService {
  final ApiService _apiService = ApiService();
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<StoreOwner> login(String email, String password) async {
    try {
      final response = await _apiService.post('/customer/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        await _secureStorage.saveToken(data['token']);
        return StoreOwner.fromJson(data['account']);
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Login failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<StoreOwner> signup(Map<String, dynamic> signupData) async {
    try {
      final response =
          await _apiService.post('/customer/register', data: signupData);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        await _secureStorage.saveToken(data['token']);
        return StoreOwner.fromJson(data['account']);
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Signup failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      final response = await _apiService.post('/customer/logout');

      if (response.statusCode == 200) {
        await _secureStorage.clearToken();
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Logout failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
