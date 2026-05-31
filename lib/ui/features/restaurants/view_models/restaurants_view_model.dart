import 'package:flutter/foundation.dart';
import 'package:deltafood/domain/models/restaurant.dart';
import 'package:deltafood/domain/use_cases/get_restaurants.dart';

class RestaurantsViewModel extends ChangeNotifier {
  final GetRestaurantsUseCase _getRestaurantsUseCase;

  RestaurantsViewModel({required GetRestaurantsUseCase getRestaurantsUseCase})
      : _getRestaurantsUseCase = getRestaurantsUseCase;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchRestaurants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _restaurants = await _getRestaurantsUseCase.execute();
    } catch (e) {
      _error = "Error fetching restaurant list: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
