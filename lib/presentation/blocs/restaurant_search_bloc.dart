import 'dart:async';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/core/usecases/search_restaurants.dart';

class SearchRestaurantBloc {
  final SearchRestaurantsUseCase _searchRestaurantUseCase;
  final _searchRestaurantController = StreamController<List<Restaurant>>();

  SearchRestaurantBloc(this._searchRestaurantUseCase);

  Stream<List<Restaurant>> get searchResults => _searchRestaurantController.stream;

  void searchRestaurants(String query) async {
    try {
      final result = await _searchRestaurantUseCase.execute(query);
      _searchRestaurantController.sink.add(result);
    } catch (error) {
      _searchRestaurantController.addError("Error Search Restaurant : $error");
    }
  }

  void dispose() {
    _searchRestaurantController.close();
  }
}