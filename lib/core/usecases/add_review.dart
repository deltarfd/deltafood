import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/core/entities/review.dart';

class AddReviewUseCase {
  final RestaurantRepository repository;

  AddReviewUseCase(this.repository);

  Future<List<Review>> execute(String id, String name, String review) async {
    return await repository.addReview(id, name, review);
  }
}