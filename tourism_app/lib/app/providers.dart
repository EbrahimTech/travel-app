import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/dio_client.dart';
import '../features/places/data/datasources/city_remote_datasource.dart';
import '../features/places/data/datasources/place_remote_datasource.dart';
import '../features/places/data/repositories/city_repository_impl.dart';
import '../features/places/data/repositories/place_repository_impl.dart';
import '../features/places/domain/repositories/city_repository.dart';
import '../features/places/domain/repositories/place_repository.dart';
import '../features/places/domain/usecases/get_cities.dart';
import '../features/places/domain/usecases/get_places.dart';
import '../features/places/presentation/providers/city_list_notifier.dart';
import '../features/places/presentation/providers/place_list_notifier.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final cityRemoteDataSourceProvider = Provider<CityRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CityRemoteDataSourceImpl(dioClient);
});

final placeRemoteDataSourceProvider = Provider<PlaceRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PlaceRemoteDataSourceImpl(dioClient);
});

final cityRepositoryProvider = Provider<CityRepository>((ref) {
  final remoteDataSource = ref.watch(cityRemoteDataSourceProvider);
  return CityRepositoryImpl(remoteDataSource);
});

final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  final remoteDataSource = ref.watch(placeRemoteDataSourceProvider);
  return PlaceRepositoryImpl(remoteDataSource);
});

final getCitiesProvider = Provider<GetCities>((ref) {
  final repository = ref.watch(cityRepositoryProvider);
  return GetCities(repository);
});

final getPlacesProvider = Provider<GetPlaces>((ref) {
  final repository = ref.watch(placeRepositoryProvider);
  return GetPlaces(repository);
});

final cityListNotifierProvider =
    StateNotifierProvider<CityListNotifier, CityListState>((ref) {
      final getCities = ref.watch(getCitiesProvider);
      return CityListNotifier(getCities: getCities);
    });

final placeListNotifierProvider =
    StateNotifierProvider<PlaceListNotifier, PlaceListState>((ref) {
      final getPlaces = ref.watch(getPlacesProvider);
      return PlaceListNotifier(getPlaces);
    });
