import 'dart:async';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/core/usecases/get_restaurant.dart';

class RestaurantBloc {
  final GetRestaurantUseCase _getRestaurantUseCase;
  final _restaurantController = StreamController<Restaurant>();

  RestaurantBloc(this._getRestaurantUseCase);

  Stream<Restaurant> get restaurant => _restaurantController.stream;

  void fetchRestaurant(String restaurantId) async {
    try {
      final result = await _getRestaurantUseCase.execute(restaurantId);
      _restaurantController.sink.add(result);
    } catch (error) {
      _restaurantController.addError("Error fetching restaurant detail: $error");
    }
  }

  void dispose() {
    _restaurantController.close();
  }
}