import 'package:dio/dio.dart';
import 'package:movies_app/core/error_handler/dio_error_handler.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/features/person_details/data/apis/person_details_api_service.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';

class PersonDetailsRepo {
  final PersonDetailsApiService _apiService;

  PersonDetailsRepo(this._apiService);

  Future<DataResult<PersonDetailsResponseModel>> getPersonDetails({
    required int personId,
    String? language,
  }) async {
    try {
      final apiKey = await LocalSecureStorage.tmdbApiKey;
      final result = await _apiService.getPersonDetails(
        personId: personId,
        language: language,
        apiKey: apiKey,
      );
      return DataResult.success(result);
    } on DioException catch (e) {
      return DataResult.error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return DataResult.error(DioErrorHandler.handleGeneralError(e));
    }
  }
}
