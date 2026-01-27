import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/place.dart';
import '../../domain/usecases/get_places.dart';

const _errorSentinel = Object();

class PlaceListState {
  const PlaceListState({
    this.isLoading = false,
    this.places = const [],
    this.error,
  });

  final bool isLoading;
  final List<Place> places;
  final String? error;

  PlaceListState copyWith({
    bool? isLoading,
    List<Place>? places,
    Object? error = _errorSentinel,
  }) {
    return PlaceListState(
      isLoading: isLoading ?? this.isLoading,
      places: places ?? this.places,
      error: identical(error, _errorSentinel) ? this.error : error as String?,
    );
  }
}

class PlaceListNotifier extends StateNotifier<PlaceListState> {
  PlaceListNotifier(this._getPlaces) : super(const PlaceListState());

  final GetPlaces _getPlaces;

  Future<void> loadPlaces({String? citySlug, String? categorySlug}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final places = await _getPlaces(
        citySlug: citySlug,
        categorySlug: categorySlug,
      );
      state = state.copyWith(isLoading: false, places: places, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
