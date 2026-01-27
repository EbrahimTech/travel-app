import '../entities/place.dart';

abstract class PlaceRepository {
  Future<List<Place>> getPlaces({String? citySlug, String? categorySlug});
}
