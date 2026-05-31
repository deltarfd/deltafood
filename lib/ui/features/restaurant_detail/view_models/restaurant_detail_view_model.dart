import 'package:flutter/foundation.dart';
import 'package:deltafood/domain/models/restaurant.dart';
import 'package:deltafood/domain/use_cases/get_restaurant.dart';
import 'package:deltafood/domain/models/review.dart';
import 'package:deltafood/domain/use_cases/add_review.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  final GetRestaurantUseCase _getRestaurantUseCase;
  final AddReviewUseCase _addReviewUseCase;

  RestaurantDetailViewModel({
    required GetRestaurantUseCase getRestaurantUseCase,
    required AddReviewUseCase addReviewUseCase,
  })  : _getRestaurantUseCase = getRestaurantUseCase,
        _addReviewUseCase = addReviewUseCase;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchRestaurant(String restaurantId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _restaurant = await _getRestaurantUseCase.execute(restaurantId);
    } catch (e) {
      _error = "Error fetching restaurant detail: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addReview(Review review) async {
    try {
      final updatedReviews = await _addReviewUseCase.execute(review.id ?? '', review.name, review.review);
      if (_restaurant != null) {
        _restaurant!.customerReviews = updatedReviews;
        notifyListeners();
      }
    } catch (e) {
      _error = "Error adding review: $e";
      notifyListeners();
    }
  }
}
