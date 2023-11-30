import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/core/entities/review.dart';

class RemoteDataSource {
  final String baseUrl;

  RemoteDataSource(this.baseUrl);
  Future<List<Restaurant>> getRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['restaurants'] as List)
          .map((json) => Restaurant.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<Restaurant> getRestaurant(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Restaurant.fromJson(data['restaurant']);
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['restaurants'] as List)
          .map((json) => Restaurant.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<List<Review>> addReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse('$baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'name': name, 'review': review}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final reviews = (data['customerReviews'] as List)
          .map((json) => Review.fromJson(json))
          .toList();
      return reviews;
    } else {
      throw Exception('Failed to add review');
    }
  }
}
