import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/place_model.dart';

abstract class PlaceRemoteDataSource {
  Future<List<PlaceModel>> getPlaces({String? citySlug, String? categorySlug});
}

class PlaceRemoteDataSourceImpl implements PlaceRemoteDataSource {
  PlaceRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<PlaceModel>> getPlaces({
    String? citySlug,
    String? categorySlug,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};
      if (citySlug != null) queryParameters['city'] = citySlug;
      if (categorySlug != null) queryParameters['category'] = categorySlug;

      final Response<dynamic> response = await _dioClient.dio.get(
        '/places/',
        queryParameters: queryParameters.isEmpty ? null : queryParameters,
      );

      if (response.statusCode == 200 && response.data is List) {
        final data = response.data as List<dynamic>;
        return data
            .cast<Map<String, dynamic>>()
            .map(PlaceModel.fromJson)
            .toList();
      }

      throw ServerException('Unexpected status code ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    } catch (_) {
      throw const ServerException('Failed to parse places');
    }
  }
}
