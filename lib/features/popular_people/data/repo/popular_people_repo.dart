import 'package:dio/dio.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/features/popular_people/data/apis/popular_people_api_service.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';

class PopularPeopleRepo {
  final PopularPeopleApiService _apiService;

  PopularPeopleRepo(this._apiService);

  Future<DataResult<PopularPeopleResponseModel>> getPopularPeople({
    int page = 1,
    String? language,
  }) async {
    try {
      final apiKey = await LocalSecureStorage.tmdbApiKey;
      final result = await _apiService.getPopularPeople(
        page: page,
        language: language,
        apiKey: apiKey,
      );
      return DataResult.success(result);
    } on DioException catch (e) {
      return DataResult.error(_handleDioError(e));
    } catch (e) {
      return DataResult.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Response timeout. Please try again.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 401:
            return 'Unauthorized. Please check your API key.';
          case 404:
            return 'Resource not found.';
          case 500:
            return 'Server error. Please try again later.';
          default:
            return 'HTTP Error: $statusCode';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.badCertificate:
        return 'Certificate error. Please try again.';
      case DioExceptionType.unknown:
        return 'Network error: ${error.message}';
    }
  }
}
