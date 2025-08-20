import 'package:dio/dio.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'person_details_api_service.g.dart';
@RestApi(baseUrl: TmdbApiConstants.baseUrl)
abstract class PersonDetailsApiService {
  factory PersonDetailsApiService(Dio dio, {String baseUrl}) =
      _PersonDetailsApiService;

  @GET(TmdbApiConstants.personDetails)
  Future<PersonDetailsResponseModel> getPersonDetails({
    @Path('personId') required int personId,
    @Query('language') String? language,
    @Query('api_key') required String apiKey,
  });
}