import 'package:deltafood/domain/models/restaurant.dart';
import 'package:deltafood/domain/repositories/restaurant_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantRepository repository;

  GetRestaurantsUseCase(this.repository);

  Future<List<Restaurant>> execute() async {
    return await repository.getRestaurants();
  }
}
