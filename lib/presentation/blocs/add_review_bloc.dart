import 'dart:async';
import 'package:deltafood/core/entities/review.dart';
import 'package:deltafood/core/usecases/add_review.dart';

class AddReviewBloc {
  final AddReviewUseCase _addReviewUseCase;
  final _addReviewController = StreamController<List<Review>>();

  AddReviewBloc(this._addReviewUseCase);
  Stream<List<Review>> get customerReviews => _addReviewController.stream;

  void addReview(Review review) async {
    try {
      final updatedReviews = await _addReviewUseCase.execute(review.id ?? '', review.name, review.date);
      _addReviewController.sink.add(updatedReviews);
    } catch (error) {
      _addReviewController.addError("Error adding review: $error");
    }
  }

  void dispose() {
    _addReviewController.close();
  }
}