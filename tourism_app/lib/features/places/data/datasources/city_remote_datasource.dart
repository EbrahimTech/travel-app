import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/city_model.dart';

abstract class CityRemoteDataSource {
  Future<List<CityModel>> getCities();
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  CityRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final Response<dynamic> response = await _dioClient.dio.get('/cities/');
      if (response.statusCode == 200 && response.data is List) {
        final data = response.data as List<dynamic>;
        return data
            .cast<Map<String, dynamic>>()
            .map(CityModel.fromJson)
            .toList();
      }

      throw ServerException('Unexpected status code ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    } catch (_) {
      throw const ServerException('Failed to parse cities');
    }
  }
}
