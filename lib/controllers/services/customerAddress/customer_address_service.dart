import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/customer_address.dart';

class CustomerAddressService {
  final ApiService _apiService = ApiService();

  /// Fetch all customer addresses
  Future<List<CustomerAddress>> getUserAddresses() async {
    try {
      final response = await _apiService.get('/customer/customer-address/list');
      if (response.statusCode == 200) {
        final List addresses = jsonDecode(response.body)['data'];
        return addresses.map((json) => CustomerAddress.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch customer addresses');
      }
    } catch (e) {
      throw Exception('Error fetching addresses: $e');
    }
  }

  /// Fetch a specific address by ID
  Future<CustomerAddress> getAddressById(int id) async {
    try {
      final response = await _apiService.get('/customer/customer-address/$id');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return CustomerAddress.fromJson(data);
      } else {
        throw Exception('Failed to fetch address');
      }
    } catch (e) {
      throw Exception('Error fetching address: $e');
    }
  }

  /// Create a new address
  Future<void> createAddress(Map<String, dynamic> addressData) async {
    try {
      final response = await _apiService
          .post('/customer/customer-address/create', data: addressData);
      if (response.statusCode != 201) {
        throw Exception('Failed to create address');
      }
    } catch (e) {
      throw Exception('Error creating address: $e');
    }
  }

  /// Update an existing address
  Future<void> updateAddress(int id, Map<String, dynamic> addressData) async {
    try {
      final response = await _apiService.put('/customer/customer-address/$id',
          data: addressData);
      if (response.statusCode != 201) {
        throw Exception('Failed to update address');
      }
    } catch (e) {
      throw Exception('Error updating address: $e');
    }
  }

  /// Delete an address
  Future<void> deleteAddress(int id) async {
    try {
      final response =
          await _apiService.delete('/customer/customer-address/$id');
      if (response.statusCode != 201) {
        throw Exception('Failed to delete address');
      }
    } catch (e) {
      throw Exception('Error deleting address: $e');
    }
  }
}
