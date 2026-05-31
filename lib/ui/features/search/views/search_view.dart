import 'package:flutter/material.dart';
import 'package:deltafood/ui/features/restaurants/views/restaurant_item_view.dart';
import 'package:deltafood/ui/features/search/view_models/search_view_model.dart';
import 'package:deltafood/ui/global/view_models/settings_view_model.dart';
import 'package:deltafood/injection/di.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final _viewModel = sl<SearchViewModel>();
  final _settingsViewModel = sl<SettingsViewModel>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _viewModel.searchRestaurants(query);
    }
    // Call setState to update the UI when the search field is empty/not-empty
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settingsViewModel,
      builder: (context, _) {
        final isGrid = _settingsViewModel.isGrid;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search', style: TextStyle(fontWeight: FontWeight.bold)),
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
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search restaurants, foods...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  ),
                ),
              ),
              Expanded(
                child: ListenableBuilder(
                  listenable: _viewModel,
                  builder: (context, _) {
                    if (_searchController.text.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_rounded, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Find your favorite foods!', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      );
                    }

                    if (_viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_viewModel.error != null) {
                      return Center(child: Text(_viewModel.error!));
                    }

                    final searchResults = _viewModel.searchResults;
                    if (searchResults.isNotEmpty) {
                      if (isGrid) {
                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return RestaurantItem(
                              restaurant: searchResults[index],
                              isGrid: true,
                            );
                          },
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return RestaurantItem(
                            restaurant: searchResults[index],
                            isGrid: false,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No results found.', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
