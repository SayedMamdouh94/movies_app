// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFileResponseModel _$UploadFileResponseModelFromJson(
  Map<String, dynamic> json,
) => UploadFileResponseModel(
  statusCode: (json['statusCode'] as num?)?.toInt(),
  message: json['message'] as String,
  data: json['data'] as String?,
  success: json['success'] as bool,
);
