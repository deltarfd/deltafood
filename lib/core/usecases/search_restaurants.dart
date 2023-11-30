import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/core/entities/restaurant.dart';

class SearchRestaurantsUseCase {
  final RestaurantRepository repository;

  SearchRestaurantsUseCase(this.repository);

  Future<List<Restaurant>> execute(String query) async {
    return await repository.searchRestaurants(query);
  }
}