import 'package:flutter/material.dart';

import 'package:deltafood/injection/di.dart';
import 'package:deltafood/ui/features/restaurants/views/restaurant_item_view.dart';
import 'package:deltafood/ui/features/restaurants/view_models/restaurants_view_model.dart';
import 'package:deltafood/ui/global/view_models/settings_view_model.dart';

class RestaurantsView extends StatefulWidget {
  const RestaurantsView({super.key});

  @override
  State<RestaurantsView> createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<RestaurantsView> {
  final RestaurantsViewModel _viewModel = sl<RestaurantsViewModel>();
  final SettingsViewModel _settingsViewModel = sl<SettingsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settingsViewModel,
      builder: (context, _) {
        final isGrid = _settingsViewModel.isGrid;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Discover', style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: false,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded),
                onPressed: () {
                  _settingsViewModel.toggleGridLayout();
                },
              ),
            ],
          ),
          body: ListenableBuilder(
            listenable: _viewModel,
            builder: (context, _) {
              if (_viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_viewModel.error != null) {
                return Center(child: Text(_viewModel.error!));
              }

              final restaurants = _viewModel.restaurants;
              if (restaurants.isEmpty) {
                return const Center(child: Text('No restaurants found.'));
              }

              if (isGrid) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75, // Adjust based on visual testing
                  ),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantItem(
                      restaurant: restaurants[index],
                      isGrid: true,
                    );
                  },
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantItem(
                    restaurant: restaurants[index],
                    isGrid: false,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
