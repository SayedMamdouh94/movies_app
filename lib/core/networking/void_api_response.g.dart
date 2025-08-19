// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'void_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoidApiResponse _$VoidApiResponseFromJson(Map<String, dynamic> json) =>
    VoidApiResponse(
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$VoidApiResponseToJson(VoidApiResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'success': instance.success,
    };
