import 'package:flutter/material.dart';
import 'package:deltafood/core/entities/category.dart';
import 'package:deltafood/core/entities/menu.dart';
import 'package:deltafood/core/entities/menus.dart';
import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/core/entities/review.dart';
import 'package:deltafood/injection/di.dart';
import 'package:deltafood/presentation/blocs/restaurant_bloc.dart';


class RestaurantView extends StatefulWidget {
  final String restaurantId;

  const RestaurantView(this.restaurantId, {super.key});

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  final RestaurantBloc _restaurantBloc = sl<RestaurantBloc>();

  @override
  void initState() {
    super.initState();
    _restaurantBloc.fetchRestaurant(widget.restaurantId);
  }

  @override
  void dispose() {
    _restaurantBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Detail'),
      ),
      body: StreamBuilder<Restaurant>(
        stream: _restaurantBloc.restaurant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return buildRestaurantDetails(snapshot.data);
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  Widget buildRestaurantDetails(Restaurant? restaurant) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            restaurant?.getImageUrl('medium') ?? '',
            height: 200, // Adjust the height as needed
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Rating in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant?.name ?? '',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant?.rating}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                buildSubtitle('Description', restaurant?.description),
                const SizedBox(height: 8),
                buildSubtitle('City', restaurant?.city),
                const SizedBox(height: 8),
                buildSubtitle('Address', restaurant?.address),
                const SizedBox(height: 8),
                buildSubtitle('Categories', getCategories(restaurant?.categories)),
                const SizedBox(height: 8),
                const Text(
                  'Menus:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                buildMenus(restaurant?.menus),
                const SizedBox(height: 8),
                buildSubtitle('Customer Reviews', ''),
                buildCustomerReviews(restaurant?.customerReviews),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubtitle(String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          content ?? '',
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  String getCategories(List<Category>? categories) {
    return categories?.map((category) => category.name).join(', ') ?? '';
  }

  Widget buildMenus(Menus? menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Foods: ${getMenuNames(menus?.foods)}'),
        Text('Drinks: ${getMenuNames(menus?.drinks)}'),
      ],
    );
  }

  String getMenuNames(List<Menu>? menuItems) {
    return menuItems?.map((menu) => menu.name).join(', ') ?? '';
  }

  Widget buildCustomerReviews(List<Review>? reviews) {
    return Container(
      alignment: Alignment.centerRight,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: reviews?.map((review) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${review.name}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Review: ${review.review}'),
                  const SizedBox(height: 8),
                  Text('Date: ${review.date}'),
                ],
              ),
            ),
          );
        }).toList() ?? [],
      ),
    );
  }
}
