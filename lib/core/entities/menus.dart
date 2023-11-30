import 'menu.dart';

class Menus {
  final List<Menu> foods;
  final List<Menu> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Menu>.from((json['foods'] ?? []).map((food) => Menu.fromJson(food))),
      drinks: List<Menu>.from((json['drinks'] ?? []).map((drink) => Menu.fromJson(drink))),
    );
  }
}