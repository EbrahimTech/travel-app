import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/city.dart';
import '../../domain/usecases/get_cities.dart';

class CityListState {
  const CityListState({
    this.isLoading = false,
    this.cities = const [],
    this.error,
    this.selectedCity,
  });

  final bool isLoading;
  final List<City> cities;
  final String? error;
  final City? selectedCity;

  CityListState copyWith({
    bool? isLoading,
    List<City>? cities,
    String? error,
    City? selectedCity,
    bool clearSelectedCity = false,
  }) {
    return CityListState(
      isLoading: isLoading ?? this.isLoading,
      cities: cities ?? this.cities,
      error: error,
      selectedCity: clearSelectedCity ? null : (selectedCity ?? this.selectedCity),
    );
  }
}

class CityListNotifier extends StateNotifier<CityListState> {
  CityListNotifier({required GetCities getCities})
    : _getCities = getCities,
      super(const CityListState());

  final GetCities _getCities;

  Future<void> loadCities() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cities = await _getCities();
      state = state.copyWith(isLoading: false, cities: cities, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectCity(City? city) {
    if (city == null) {
      state = state.copyWith(clearSelectedCity: true);
    } else {
      state = state.copyWith(selectedCity: city);
    }
  }
}
