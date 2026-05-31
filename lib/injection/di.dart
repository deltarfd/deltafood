import 'package:get_it/get_it.dart';
import 'package:deltafood/ui/global/view_models/settings_view_model.dart';
import 'package:deltafood/domain/use_cases/add_review.dart';
import 'package:deltafood/domain/use_cases/get_restaurant.dart';
import 'package:deltafood/domain/use_cases/get_restaurants.dart';
import 'package:deltafood/domain/use_cases/search_restaurants.dart';
import 'package:deltafood/data/services/remote_datasource.dart';
import 'package:deltafood/data/repositories/restaurant_repository_impl.dart';
import 'package:deltafood/domain/repositories/restaurant_repository.dart';
import 'package:deltafood/ui/features/restaurants/view_models/restaurants_view_model.dart';
import 'package:deltafood/ui/features/restaurant_detail/view_models/restaurant_detail_view_model.dart';
import 'package:deltafood/ui/features/search/view_models/search_view_model.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Global Settings
  sl.registerLazySingleton(() => SettingsViewModel());

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

  // Registering ViewModels
  sl.registerFactory(() => RestaurantsViewModel(getRestaurantsUseCase: sl<GetRestaurantsUseCase>()));
  sl.registerFactory(() => RestaurantDetailViewModel(
    getRestaurantUseCase: sl<GetRestaurantUseCase>(),
    addReviewUseCase: sl<AddReviewUseCase>(),
  ));
  sl.registerFactory(() => SearchViewModel(searchRestaurantUseCase: sl<SearchRestaurantsUseCase>()));
}
