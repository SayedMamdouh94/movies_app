
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/networking/api_response.dart';

part 'upload_file_response_model.g.dart';

@JsonSerializable(createToJson: false)
class UploadFileResponseModel extends ApiResponse<String> {
  UploadFileResponseModel({
    required super.statusCode,
    required super.message,
    required super.data,
    required super.success,
  });

  factory UploadFileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UploadFileResponseModelFromJson(json);
}
