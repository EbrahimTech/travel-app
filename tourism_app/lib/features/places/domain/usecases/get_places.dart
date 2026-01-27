import '../entities/place.dart';
import '../repositories/place_repository.dart';

class GetPlaces {
  const GetPlaces(this.repository);

  final PlaceRepository repository;

  Future<List<Place>> call({String? citySlug, String? categorySlug}) {
    return repository.getPlaces(citySlug: citySlug, categorySlug: categorySlug);
  }
}
