import 'dart:convert';
import 'package:wasly/controllers/services/api_service.dart';
import 'package:wasly/models/review.dart';

class ReviewService {
  final ApiService _apiService = ApiService();

  /// Add a review for a product
  Future<void> addReview(
      int productId, int ratingId, String description) async {
    try {
      final response = await _apiService.post('/review/add/$productId', data: {
        'rating_id': ratingId,
        'description': description,
      });

      if (response.statusCode != 201) {
        final message =
            jsonDecode(response.body)['message'] ?? 'Failed to add review';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

  /// Update an existing review
  Future<void> updateReview(
      int reviewId, int ratingId, String description) async {
    try {
      final response = await _apiService.put('/review/update/$reviewId', data: {
        'rating_id': ratingId,
        'description': description,
      });

      if (response.statusCode != 200) {
        final message =
            jsonDecode(response.body)['message'] ?? 'Failed to update review';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to update review: $e');
    }
  }

  /// Remove a review
  Future<void> removeReview(int reviewId) async {
    try {
      final response = await _apiService.delete('/review/remove/$reviewId');

      if (response.statusCode != 200) {
        final message =
            jsonDecode(response.body)['message'] ?? 'Failed to remove review';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to remove review: $e');
    }
  }

  /// Get reviews for a product
  Future<List<Review>> getProductReviews(int productId) async {
    try {
      final response = await _apiService.get('/review/product/$productId');

      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ??
            'Failed to fetch product reviews';
        throw Exception(message);
      }

      final data = jsonDecode(response.body)['data'] as List;
      return data.map((json) => Review.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch product reviews: $e');
    }
  }

  /// Get reviews for a store
  Future<List<Review>> getStoreReviews(int storeId) async {
    try {
      final response = await _apiService.get('/review/store/$storeId');

      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)['message'] ??
            'Failed to fetch store reviews';
        throw Exception(message);
      }

      final data = jsonDecode(response.body)['data'] as List;
      return data.map((json) => Review.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch store reviews: $e');
    }
  }
}
