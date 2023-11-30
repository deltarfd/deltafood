import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/core/entities/restaurant.dart';

class GetRestaurantUseCase {
  final RestaurantRepository repository;

  GetRestaurantUseCase(this.repository);

  Future<Restaurant> execute(String id) async {
    return await repository.getRestaurant(id);
  }
}
