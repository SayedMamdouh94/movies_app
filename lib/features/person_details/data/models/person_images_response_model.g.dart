// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_images_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonImagesResponseModel _$PersonImagesResponseModelFromJson(
  Map<String, dynamic> json,
) => PersonImagesResponseModel(
  id: (json['id'] as num).toInt(),
  profiles: (json['profiles'] as List<dynamic>)
      .map((e) => PersonImageModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

PersonImageModel _$PersonImageModelFromJson(Map<String, dynamic> json) =>
    PersonImageModel(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: (json['height'] as num).toInt(),
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      width: (json['width'] as num).toInt(),
    );
