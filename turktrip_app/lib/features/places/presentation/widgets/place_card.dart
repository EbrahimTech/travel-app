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

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hasImage
                ? Image.network(
                    place.coverImageUrl!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.photo, size: 48, color: Colors.grey),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (infoParts.isNotEmpty)
                    Text(
                      infoParts.join(' · '),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        place.avgRating != null
                            ? '${place.avgRating}'
                            : 'No rating',
                      ),
                      if (place.totalReviews != null) ...[
                        const SizedBox(width: 8),
                        Text('(${place.totalReviews} reviews)'),
                      ],
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
