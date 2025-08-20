import 'package:json_annotation/json_annotation.dart';

part 'popular_people_response_model.g.dart';

@JsonSerializable(createToJson: false)
class PopularPeopleResponseModel {
  final int page;
  final List<PopularPersonModel> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  PopularPeopleResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularPeopleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PopularPeopleResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PopularPersonModel {
  final bool adult;
  final int gender;
  final int id;
  @JsonKey(name: 'known_for')
  final List<PopularPersonKnownForModel> knownFor;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  final double popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  PopularPersonModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    this.profilePath,
  });

  factory PopularPersonModel.fromJson(Map<String, dynamic> json) =>
      _$PopularPersonModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PopularPersonKnownForModel {
  final bool? adult;
  final int id;
  @JsonKey(name: 'media_type')
  final String mediaType;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'original_name')
  final String? originalName;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  final String? title;
  final String? name;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final bool? video;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  PopularPersonKnownForModel({
    this.adult,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    this.originalTitle,
    this.originalName,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.firstAirDate,
    this.title,
    this.name,
    this.voteAverage,
    this.voteCount,
    this.video,
    this.genreIds,
    this.originCountry,
  });

  factory PopularPersonKnownForModel.fromJson(Map<String, dynamic> json) =>
      _$PopularPersonKnownForModelFromJson(json);
}
