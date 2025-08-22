class TmdbApiConstants {
  TmdbApiConstants._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';

  // People endpoints
  static const String popularPeople = 'person/popular';

  // Person details endpoint
  static const String personDetails = 'person/{personId}';

  // Person images endpoint
  static const String personImages = 'person/{personId}/images';

  // Images
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/';
  static const String posterSize = 'w500';
  static const String backdropSize = 'w1280';
  static const String profileSize = 'w200';

  // Helper methods for image URLs
  static String getPosterUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) return '';
    return '$imageBaseUrl$posterSize$posterPath';
  }

  static String getBackdropUrl(String? backdropPath) {
    if (backdropPath == null || backdropPath.isEmpty) return '';
    return '$imageBaseUrl$backdropSize$backdropPath';
  }

  static String getProfileUrl(String? profilePath) {
    if (profilePath == null || profilePath.isEmpty) return '';
    return '$imageBaseUrl$profileSize$profilePath';
  }

  static String getImageUrl(String? imagePath, {String size = 'w500'}) {
    if (imagePath == null || imagePath.isEmpty) return '';
    return '$imageBaseUrl$size$imagePath';
  }
}
