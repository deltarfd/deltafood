import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/core/entities/review.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants();
  Future<Restaurant> getRestaurant(String restaurantId);
  Future<List<Restaurant>> searchRestaurants(String query);
  Future<List<Review>> addReview(String id, String name, String review);
}