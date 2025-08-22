import 'package:dio/dio.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'popular_people_api_service.g.dart';

@RestApi(baseUrl: TmdbApiConstants.baseUrl)
abstract class PopularPeopleApiService {
  factory PopularPeopleApiService(Dio dio, {String baseUrl}) =
      _PopularPeopleApiService;

  @GET(TmdbApiConstants.popularPeople)
  Future<PopularPeopleResponseModel> getPopularPeople({
    @Query('page') int page = 1,
    @Query('language') String? language,
    @Query('api_key') required String apiKey,
  });
}
