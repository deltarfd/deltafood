import 'dart:async';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/core/usecases/get_restaurants.dart';

class RestaurantsBloc {
  final GetRestaurantsUseCase _getRestaurantsUseCase;
  final _restaurantsController = StreamController<List<Restaurant>>();
  RestaurantsBloc(this._getRestaurantsUseCase);
  Stream<List<Restaurant>> get restaurantList => _restaurantsController.stream;

  void fetchRestaurants() async {
    try {
      final result = await _getRestaurantsUseCase.execute();
      _restaurantsController.sink.add(result);
    } catch (error) {
      _restaurantsController.addError("Error fetching restaurant list: $error");
    }
  }

  void dispose() {
    _restaurantsController.close();
  }
}