import 'package:deltafood/domain/models/restaurant.dart';
import 'package:deltafood/domain/models/review.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants();
  Future<Restaurant> getRestaurant(String restaurantId);
  Future<List<Restaurant>> searchRestaurants(String query);
  Future<List<Review>> addReview(String id, String name, String review);
}
