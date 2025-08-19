import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';

part 'void_api_response.g.dart';

@JsonSerializable()
class VoidApiResponse extends ApiResponse<void> {
  VoidApiResponse({
    required super.message,
    required super.statusCode,
    required super.success,
  }) : super(data: null);

  factory VoidApiResponse.fromJson(Map<String, dynamic> json) =>
      _$VoidApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VoidApiResponseToJson(this);
}
