import '../../domain/entities/place.dart';

class PlaceModel extends Place {
  PlaceModel({
    required int id,
    required String name,
    String? description,
    String? address,
    double? avgRating,
    int? totalReviews,
    String? cityName,
    String? categoryName,
    String? coverImageUrl,
  }) : super(
         id: id,
         name: name,
         description: description,
         address: address,
         avgRating: avgRating,
         totalReviews: totalReviews,
         cityName: cityName,
         categoryName: categoryName,
         coverImageUrl: coverImageUrl,
       );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final city = json['city'] as Map<String, dynamic>?;
    final category = json['category'] as Map<String, dynamic>?;
    final images = (json['images'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    String? coverImage;
    if (images.isNotEmpty) {
      final cover = images.firstWhere(
        (img) => img['is_cover'] == true,
        orElse: () => images.first,
      );
      coverImage = cover['image_url'] as String?;
    }

    return PlaceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String?,
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
      totalReviews: json['total_reviews'] as int?,
      cityName: city?['name'] as String?,
      categoryName: category?['name'] as String?,
      coverImageUrl: coverImage,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'address': address,
    'avg_rating': avgRating,
    'total_reviews': totalReviews,
    'city': {'name': cityName},
    'category': {'name': categoryName},
    'cover_image_url': coverImageUrl,
  };

  Place toEntity() => this;
}
