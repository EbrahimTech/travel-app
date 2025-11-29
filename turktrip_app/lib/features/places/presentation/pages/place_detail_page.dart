import 'package:flutter/material.dart';

import '../../domain/entities/place.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        place.coverImageUrl != null && place.coverImageUrl!.isNotEmpty;
    final infoParts = [
      place.cityName,
      place.categoryName,
    ].whereType<String>().where((value) => value.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hasImage
                ? Image.network(
                    place.coverImageUrl!,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 240,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.photo, size: 64, color: Colors.grey),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (infoParts.isNotEmpty)
                    Text(
                      infoParts.join(' · '),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  const SizedBox(height: 16),
                  // Rating Badge (TripAdvisor Style)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: place.avgRating != null && place.avgRating! >= 4.0
                              ? const Color(0xFF00AA6C) // TripAdvisor Green
                              : place.avgRating != null && place.avgRating! >= 3.0
                                  ? Colors.orange.shade400
                                  : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              place.avgRating != null
                                  ? place.avgRating!.toStringAsFixed(1)
                                  : '--',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (place.totalReviews != null && place.totalReviews! > 0)
                        Text(
                          '${place.totalReviews} reviews',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      else
                        Text(
                          'No reviews yet',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Description Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description, 
                              color: const Color(0xFF00AA6C), 
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Description',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          place.description ?? 'No description available.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade800,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Address Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, 
                              color: const Color(0xFF00AA6C), 
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Address',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          place.address ?? 'Address not provided.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Reviews Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.reviews, 
                              color: const Color(0xFF00AA6C), 
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Reviews',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Reviews will be shown here...',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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
