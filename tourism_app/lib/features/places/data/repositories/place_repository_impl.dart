import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/place.dart';
import '../../domain/repositories/place_repository.dart';
import '../datasources/place_remote_datasource.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  PlaceRepositoryImpl(this.remoteDataSource);

  final PlaceRemoteDataSource remoteDataSource;

  @override
  Future<List<Place>> getPlaces({
    String? citySlug,
    String? categorySlug,
  }) async {
    try {
      final models = await remoteDataSource.getPlaces(
        citySlug: citySlug,
        categorySlug: categorySlug,
      );
      return models.map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const ServerFailure('Unexpected error fetching places');
    }
  }
}
