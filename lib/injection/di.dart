import 'package:get_it/get_it.dart';
import 'package:deltafood/core/usecases/add_review.dart';
import 'package:deltafood/core/usecases/get_restaurant.dart';
import 'package:deltafood/core/usecases/get_restaurants.dart';
import 'package:deltafood/core/usecases/search_restaurants.dart';
import 'package:deltafood/data/datasources/remote_datasource.dart';
import 'package:deltafood/data/repositories/restaurant_repository_impl.dart';
import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/presentation/blocs/add_review_bloc.dart';
import 'package:deltafood/presentation/blocs/restaurant_bloc.dart';
import 'package:deltafood/presentation/blocs/restaurant_search_bloc.dart';
import 'package:deltafood/presentation/blocs/restaurants_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Registering data sources
  sl.registerLazySingleton(() => RemoteDataSource('https://restaurant-api.dicoding.dev'));

  // Registering repositories
  sl.registerLazySingleton<RestaurantRepository>(
        () => RestaurantRepositoryImpl(sl<RemoteDataSource>()),
  );

  // Registering use cases
  sl.registerLazySingleton(() => GetRestaurantsUseCase(sl<RestaurantRepository>()));
  sl.registerLazySingleton(() => GetRestaurantUseCase(sl<RestaurantRepository>()));
  sl.registerLazySingleton(() => SearchRestaurantsUseCase(sl<RestaurantRepository>()));
  sl.registerLazySingleton(() => AddReviewUseCase(sl<RestaurantRepository>()));

  // Registering BLoCs
  sl.registerFactory(() => RestaurantsBloc(GetRestaurantsUseCase(sl<RestaurantRepository>())));
  sl.registerFactory(() => RestaurantBloc(GetRestaurantUseCase(sl<RestaurantRepository>())));
  sl.registerFactory(() => SearchRestaurantBloc(SearchRestaurantsUseCase(sl<RestaurantRepository>())));
  sl.registerFactory(() => AddReviewBloc(AddReviewUseCase(sl<RestaurantRepository>())));

}