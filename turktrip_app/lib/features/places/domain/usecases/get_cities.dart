import '../entities/city.dart';
import '../repositories/city_repository.dart';

class GetCities {
  const GetCities(this.repository);

  final CityRepository repository;

  Future<List<City>> call() {
    return repository.getCities();
  }
}
