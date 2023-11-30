import 'package:deltafood/core/entities/review.dart';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/data/datasources/remote_datasource.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      return await remoteDataSource.getRestaurants();
    } catch (e) {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Future<Restaurant> getRestaurant(String id) async {
    try {
      return await remoteDataSource.getRestaurant(id);
    } catch (e) {
      throw Exception('Failed to load restaurant details');
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      return await remoteDataSource.searchRestaurants(query);
    } catch (e) {
      throw Exception('Failed to search restaurants');
    }
  }

  @override
  Future<List<Review>> addReview(String id, String name, String review) async {
    try {
      return await remoteDataSource.addReview(id, name, review);
    } catch (e) {
      throw Exception('Failed to add review');
    }
  }
}


//
// class RestaurantRepositoryImpl implements RestaurantRepository {
//   final RemoteDataSource _remoteDataSource;
//
//   RestaurantRepositoryImpl(this._remoteDataSource);
//
//   @override
//   Future<List<RestaurantEntity>> getRestaurantList() async {
//     try {
//       final List<Map<String, dynamic>> rawData = await _remoteDataSource.get('/list');
//
//       // Convert the raw data to List<RestaurantEntity>
//       final List<RestaurantEntity> restaurantList = rawData.map((data) => RestaurantEntity.fromMap(data)).toList();
//
//       return restaurantList;
//     } catch (e) {
//       // Handle exceptions as needed
//       throw e;
//     }
//   }
// }