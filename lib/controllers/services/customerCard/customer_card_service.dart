import 'dart:convert';
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/customer_card.dart';

class CustomerCardService {
  final ApiService _apiService = ApiService();

  /// Fetch all customer cards
  Future<List<CustomerCard>> getUserCards() async {
    try {
      final response = await _apiService.get('/customer/customer-card/list');
      if (response.statusCode == 200) {
        final List cards = jsonDecode(response.body)['data'];
        return cards.map((json) => CustomerCard.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch customer cards');
      }
    } catch (e) {
      throw Exception('Error fetching customer cards: $e');
    }
  }

  /// Fetch a specific customer card by ID
  Future<CustomerCard> getCardById(int id) async {
    try {
      final response = await _apiService.get('/customer/customer-card/$id');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return CustomerCard.fromJson(data);
      } else {
        throw Exception('Failed to fetch customer card');
      }
    } catch (e) {
      throw Exception('Error fetching customer card: $e');
    }
  }

  /// Create a new customer card
  Future<void> createCard(Map<String, dynamic> cardData) async {
    try {
      final response = await _apiService.post('/customer/customer-card/create',
          data: cardData);
      if (response.statusCode != 201) {
        throw Exception('Failed to create customer card');
      }
    } catch (e) {
      throw Exception('Error creating customer card: $e');
    }
  }

  /// Update an existing customer card by ID
  Future<void> updateCard(int id, Map<String, dynamic> cardData) async {
    try {
      final response =
          await _apiService.put('/customer/customer-card/$id', data: cardData);
      if (response.statusCode != 201) {
        throw Exception('Failed to update customer card');
      }
    } catch (e) {
      throw Exception('Error updating customer card: $e');
    }
  }

  /// Delete a customer card by ID
  Future<void> deleteCard(int id) async {
    try {
      final response = await _apiService.delete('/customer/customer-card/$id');
      if (response.statusCode != 201) {
        throw Exception('Failed to delete customer card');
      }
    } catch (e) {
      throw Exception('Error deleting customer card: $e');
    }
  }
}
