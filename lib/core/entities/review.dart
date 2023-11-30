class Review {
  String? id;
  final String name;
  final String review;
  final String date;

  Review({
    this.id,
    required this.name,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      date: json['date'] ?? '',
    );
  }
}