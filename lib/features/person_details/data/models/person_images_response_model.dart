import 'package:json_annotation/json_annotation.dart';

part 'person_images_response_model.g.dart';

@JsonSerializable(createToJson: false)
class PersonImagesResponseModel {
  final int id;
  final List<PersonImageModel> profiles;

  PersonImagesResponseModel({required this.id, required this.profiles});

  factory PersonImagesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PersonImagesResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PersonImageModel {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final int width;

  PersonImageModel({
    required this.aspectRatio,
    required this.height,
    this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory PersonImageModel.fromJson(Map<String, dynamic> json) =>
      _$PersonImageModelFromJson(json);
}
