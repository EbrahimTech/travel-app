import 'package:flutter/material.dart';

import '../../domain/entities/place.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.place, this.onTap});

  final Place place;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        place.coverImageUrl != null && place.coverImageUrl!.isNotEmpty;
    final infoParts = [
      place.cityName,
      place.categoryName,
    ].whereType<String>().where((value) => value.isNotEmpty).toList();

    // TripAdvisor Green
    const Color tripAdvisorGreen = Color(0xFF00AA6C);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: hasImage
                  ? Image.network(
                      place.coverImageUrl!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.image, size: 48, color: Colors.grey),
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.image, size: 48, color: Colors.grey),
                      ),
                    ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Place Name
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Location & Category
                  if (infoParts.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            infoParts.join(' · '),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),
                  // Rating Section (TripAdvisor Style)
                  Row(
                    children: [
                      // Rating Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: place.avgRating != null && place.avgRating! >= 4.0
                              ? tripAdvisorGreen
                              : place.avgRating != null && place.avgRating! >= 3.0
                                  ? Colors.orange.shade400
                                  : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              place.avgRating != null
                                  ? place.avgRating!.toStringAsFixed(1)
                                  : '--',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Reviews Count
                      if (place.totalReviews != null && place.totalReviews! > 0)
                        Text(
                          '${place.totalReviews} reviews',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        )
                      else
                        Text(
                          'No reviews yet',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
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
