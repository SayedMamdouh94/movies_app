// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_people_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularPeopleResponseModel _$PopularPeopleResponseModelFromJson(
  Map<String, dynamic> json,
) => PopularPeopleResponseModel(
  page: (json['page'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => PopularPersonModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
);

PopularPersonModel _$PopularPersonModelFromJson(Map<String, dynamic> json) =>
    PopularPersonModel(
      adult: json['adult'] as bool,
      gender: (json['gender'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      knownFor: (json['known_for'] as List<dynamic>)
          .map(
            (e) =>
                PopularPersonKnownForModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
    );

PopularPersonKnownForModel _$PopularPersonKnownForModelFromJson(
  Map<String, dynamic> json,
) => PopularPersonKnownForModel(
  adult: json['adult'] as bool?,
  id: (json['id'] as num).toInt(),
  mediaType: json['media_type'] as String,
  originalLanguage: json['original_language'] as String,
  originalTitle: json['original_title'] as String?,
  originalName: json['original_name'] as String?,
  overview: json['overview'] as String?,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  releaseDate: json['release_date'] as String?,
  firstAirDate: json['first_air_date'] as String?,
  title: json['title'] as String?,
  name: json['name'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  voteCount: (json['vote_count'] as num?)?.toInt(),
  video: json['video'] as bool?,
  genreIds: (json['genre_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  originCountry: (json['origin_country'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);
