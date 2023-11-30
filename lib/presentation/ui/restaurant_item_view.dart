import 'package:flutter/material.dart';

import 'package:deltafood/core/entities/restaurant.dart';
import 'package:deltafood/presentation/ui/restaurant_view.dart';


class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantView(restaurant.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Restaurant Image from URL
            Align(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(restaurant.getImageUrl('medium')),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Restaurant Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text(
                            '${restaurant.rating}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant.city,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    restaurant.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}