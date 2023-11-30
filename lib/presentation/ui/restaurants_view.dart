import 'package:flutter/material.dart';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/injection/di.dart';
import 'package:deltafood/presentation/ui/restaurant_item_view.dart';

import 'package:deltafood/presentation/blocs/restaurants_bloc.dart';

class RestaurantsView extends StatefulWidget {
  const RestaurantsView({super.key});

  @override
  _RestaurantsViewState createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<RestaurantsView> {
  final RestaurantsBloc _restaurantsBloc = sl<RestaurantsBloc>();

  @override
  void initState() {
    super.initState();
    _restaurantsBloc.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: _restaurantsBloc.restaurantList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurants = snapshot.data!;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantItem(restaurant: restaurant);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _restaurantsBloc.dispose();
    super.dispose();
  }
}