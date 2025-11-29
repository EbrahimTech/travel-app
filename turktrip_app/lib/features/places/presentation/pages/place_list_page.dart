import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/place.dart';
import '../providers/city_list_notifier.dart';
import '../providers/place_list_notifier.dart';
import '../widgets/place_card.dart';
import 'place_detail_page.dart';

class PlaceListPage extends ConsumerStatefulWidget {
  const PlaceListPage({super.key});

  @override
  ConsumerState<PlaceListPage> createState() => _PlaceListPageState();
}

class _PlaceListPageState extends ConsumerState<PlaceListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(placeListNotifierProvider.notifier).loadPlaces();
      ref.read(cityListNotifierProvider.notifier).loadCities();
    });
  }

  Future<void> _reload() {
    final City? selectedCity = ref.read(cityListNotifierProvider).selectedCity;
    return ref
        .read(placeListNotifierProvider.notifier)
        .loadPlaces(citySlug: selectedCity?.slug);
  }

  void _onCitySelected(City? city) {
    ref.read(cityListNotifierProvider.notifier).selectCity(city);
    ref
        .read(placeListNotifierProvider.notifier)
        .loadPlaces(citySlug: city?.slug);
  }

  @override
  Widget build(BuildContext context) {
    final placeState = ref.watch(placeListNotifierProvider);
    final cityState = ref.watch(cityListNotifierProvider);

    final cityFilters = _buildCityFilters(cityState);
    final placesContent = _buildPlacesContent(placeState);

    return Scaffold(
      appBar: AppBar(title: const Text('TurkTrip Places')),
      body: Column(
        children: [
          cityFilters,
          Expanded(
            child: RefreshIndicator(onRefresh: _reload, child: placesContent),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reload,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildCityFilters(CityListState cityState) {
    if (cityState.isLoading && cityState.cities.isEmpty) {
      return const SizedBox(
        height: 72,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return SizedBox(
      height: 72,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            final bool selected = cityState.selectedCity == null;
            return ChoiceChip(
              label: const Text('All'),
              selected: selected,
              onSelected: (_) => _onCitySelected(null),
            );
          }
          final city = cityState.cities[index - 1];
          final bool selected = cityState.selectedCity?.id == city.id;
          return ChoiceChip(
            label: Text(city.name),
            selected: selected,
            onSelected: (_) => _onCitySelected(city),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: cityState.cities.length + 1,
      ),
    );
  }

  Widget _buildPlacesContent(PlaceListState state) {
    if (state.isLoading && state.places.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    if (state.error != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _reload,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ],
      );
    }

    if (state.places.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 200, child: Center(child: Text('No places found.'))),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: state.places.length,
      itemBuilder: (context, index) {
        final Place place = state.places[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PlaceCard(
            place: place,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PlaceDetailPage(place: place),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
