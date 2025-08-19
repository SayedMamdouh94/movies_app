import 'package:movies_app/core/data/models/upload_file_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.uploadImage)
  @MultiPart()
  Future<UploadFileResponseModel> uploadImage(
    @Body() FormData body,
    @Header('Authorization') String token,
    
  );
  @POST(ApiConstants.uploadPdf)
  @MultiPart()
  Future<UploadFileResponseModel> uploadPdf(
    @Body() FormData body,
    @Header('Authorization') String token,
  
  );
  @DELETE(ApiConstants.deleteFile)
  Future<UploadFileResponseModel> deleteFile(
    @Query('relativePath') String relativePath,
    @Header('Authorization') String token,
  );
}
