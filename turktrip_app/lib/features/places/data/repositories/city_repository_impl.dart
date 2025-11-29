import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/city_repository.dart';
import '../datasources/city_remote_datasource.dart';

class CityRepositoryImpl implements CityRepository {
  CityRepositoryImpl(this.remoteDataSource);

  final CityRemoteDataSource remoteDataSource;

  @override
  Future<List<City>> getCities() async {
    try {
      final models = await remoteDataSource.getCities();
      return models;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const ServerFailure('Unexpected error fetching cities');
    }
  }
}
