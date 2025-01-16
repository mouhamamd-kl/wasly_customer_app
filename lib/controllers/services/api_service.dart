import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasly/controllers/services/storage/secure_storage_service.dart';

class ApiService {
  final String _baseUrl =
      'https://wasly.vercel.app/api/api'; // Replace with your API base URL
  final SecureStorageService _secureStorage = SecureStorageService();

  /// Helper to build headers with the Authorization token
  Future<Map<String, String>> _buildHeaders() async {
    final token = await _secureStorage.readToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Perform a GET request
  Future<http.Response> get(String endpoint) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response = await http.get(uri, headers: headers);
    _handleResponse(response);
    return response;
  }

  /// Perform a POST request
  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response =
        await http.post(uri, headers: headers, body: jsonEncode(data));
    _handleResponse(response);
    return response;
  }

  /// Perform a PUT request
  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? data}) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response =
        await http.put(uri, headers: headers, body: jsonEncode(data));
    _handleResponse(response);
    return response;
  }

  /// Perform a DELETE request
  Future<http.Response> delete(String endpoint) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response = await http.delete(uri, headers: headers);
    _handleResponse(response);
    return response;
  }

  /// Handle response errors
  void _handleResponse(http.Response response) {
    if (response.statusCode >= 400) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] ?? 'Unknown error';
      throw Exception('HTTP ${response.statusCode}: $errorMessage');
    }
  }
}
