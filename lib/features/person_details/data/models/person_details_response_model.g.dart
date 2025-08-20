// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetailsResponseModel _$PersonDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => PersonDetailsResponseModel(
  adult: json['adult'] as bool,
  alsoKnownAs: (json['also_known_as'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  biography: json['biography'] as String,
  birthday: json['birthday'] as String?,
  deathday: json['deathday'] as String?,
  gender: (json['gender'] as num).toInt(),
  homepage: json['homepage'] as String?,
  id: (json['id'] as num).toInt(),
  imdbId: json['imdb_id'] as String,
  knownForDepartment: json['known_for_department'] as String,
  name: json['name'] as String,
  placeOfBirth: json['place_of_birth'] as String?,
  popularity: (json['popularity'] as num).toDouble(),
  profilePath: json['profile_path'] as String?,
);
