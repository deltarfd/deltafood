class Menu {
  final String name;

  Menu({required this.name});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      name: json['name'] ?? '',
    );
  }
}