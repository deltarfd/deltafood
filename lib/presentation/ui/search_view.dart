import 'package:flutter/material.dart';
import 'package:deltafood/presentation/ui/restaurant_item_view.dart';
import 'package:deltafood/presentation/blocs/restaurant_search_bloc.dart';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/injection/di.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final _searchBloc = sl<SearchRestaurantBloc>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBloc.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final query = _searchController.text;
    _searchBloc.searchRestaurants(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      resizeToAvoidBottomInset: false, // Avoid resizing when the keyboard appears
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<List<Restaurant>>(
              stream: _searchBloc.searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final searchResults = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final restaurant = searchResults[index];
                      return RestaurantItem(restaurant: restaurant);
                    },
                  );
                } else {
                  return const Center(child: Text('No search results'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
