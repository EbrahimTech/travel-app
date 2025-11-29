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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        place.avgRating != null
                            ? '${place.avgRating}'
                            : 'No rating',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (place.totalReviews != null) ...[
                        const SizedBox(width: 8),
                        Text('(${place.totalReviews} reviews)'),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description ?? 'No description available.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Address',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.address ?? 'Address not provided.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Reviews will be shown here...'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
