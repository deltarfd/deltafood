import 'package:deltafood/core/entities/review.dart';

import 'category.dart';
import 'menus.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String? address;
  final List<Category>? categories;
  final Menus? menus;
  final List<Review>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      pictureId: json['pictureId'] ?? '',
      categories: List<Category>.from((json['categories'] ?? []).map((category) => Category.fromJson(category))),
      menus: Menus.fromJson(json['menus'] ?? {}),
      rating: (json['rating'] ?? 0.0).toDouble(),
      customerReviews: List<Review>.from((json['customerReviews'] ?? []).map((review) => Review.fromJson(review))),
    );
  }

  String getImageUrl(String size) {
    return 'https://restaurant-api.dicoding.dev/images/$size/$pictureId';
  }
}