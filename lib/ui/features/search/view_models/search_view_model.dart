import 'package:flutter/foundation.dart';
import 'package:deltafood/domain/models/restaurant.dart';
import 'package:deltafood/domain/use_cases/search_restaurants.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRestaurantsUseCase _searchRestaurantUseCase;

  SearchViewModel({required SearchRestaurantsUseCase searchRestaurantUseCase})
      : _searchRestaurantUseCase = searchRestaurantUseCase;

  List<Restaurant> _searchResults = [];
  List<Restaurant> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _searchResults = await _searchRestaurantUseCase.execute(query);
    } catch (e) {
      _error = "Error Search Restaurant: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
