class Place {
  const Place({
    required this.id,
    required this.name,
    this.description,
    this.address,
    this.avgRating,
    this.totalReviews,
    this.cityName,
    this.categoryName,
    this.coverImageUrl,
  });

  final int id;
  final String name;
  final String? description;
  final String? address;
  final double? avgRating;
  final int? totalReviews;
  final String? cityName;
  final String? categoryName;
  final String? coverImageUrl;
}
