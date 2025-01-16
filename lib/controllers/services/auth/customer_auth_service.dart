import 'dart:convert';
import 'package:get/get.dart';
import 'package:wasly/controllers/auth/auth_controller.dart';
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/customer.dart';
import '../storage/secure_storage_service.dart';

class CustomerAuthService {
  final ApiService _apiService = ApiService();
  final SecureStorageService _secureStorage = SecureStorageService();
  final AuthController _authController = Get.find();

  Future<Customer> login(String email, String password) async {
    try {
      final response = await _apiService.post('/customer/login', data: {
        'email': email, // Add trim() for safety
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        await _authController.login(data['token']);
        return Customer.fromJson(data['account']);
      } else {
        final message = jsonDecode(response.body)['msg'] ?? 'Login failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<Customer> signup(Map<String, dynamic> signupData) async {
    try {
      final response =
          await _apiService.post('/customer/register', data: signupData);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        await _authController.login(data['token']);
        return Customer.fromJson(data['account']);
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Signup failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      final response = await _apiService.post('/customer/logout');

      if (response.statusCode == 200) {
        await _authController.logout();
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Logout failed';
        throw Exception(message);
      }
    } catch (e) {
      // Always logout locally even if API call fails
      await _authController.logout();
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<Customer> getCustomerInfo() async {
    try {
      final response = await _apiService.get('/customer/info');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return Customer.fromJson(data);
      } else {
        final message = jsonDecode(response.body)['message'] ??
            'Failed to get customer info';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to get customer info: ${e.toString()}');
    }
  }

  Future<Customer> updateCustomer(
      int id, Map<String, dynamic> updateData) async {
    try {
      final response =
          await _apiService.patch('/customer/$id', data: updateData);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return Customer.fromJson(data);
      } else {
        final message = jsonDecode(response.body)['msg'] ?? 'Update failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Update failed: ${e.toString()}');
    }
  }

  Future<void> deleteAccount(String id) async {
    try {
      final response = await _apiService.delete('/customer/$id');

      if (response.statusCode == 201) {
        await _authController.logout(); // Logout after successful deletion
      } else {
        final message =
            jsonDecode(response.body)['msg'] ?? 'Account deletion failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Account deletion failed: ${e.toString()}');
    }
  }
}
