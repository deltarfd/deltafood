import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deltafood/presentation/ui/profile_view.dart';
import 'package:deltafood/presentation/ui/search_view.dart';
import 'package:deltafood/presentation/ui/restaurants_view.dart';
import 'injection/di.dart';


Future<void> main() async {
  await setupDependencies();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.grey[300], // Set text color for the entire app
        ),
      ), // Switch to dark theme
      home: const RestaurantApp(),
    );
  }
}

class RestaurantApp extends StatefulWidget {
  const RestaurantApp({super.key});

  @override
  _RestaurantAppState createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const RestaurantsView(),
    const SearchView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
