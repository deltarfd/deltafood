import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/domain/models/restaurant.dart';

class SearchRestaurantsUseCase {
  final RestaurantRepository repository;

  SearchRestaurantsUseCase(this.repository);

  Future<List<Restaurant>> execute(String query) async {
    return await repository.searchRestaurants(query);
  }
}
