class TmdbApiConstants {
  TmdbApiConstants._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';

  // People endpoints
  static const String popularPeople = 'person/popular';

  // Movie endpoints
  static const String popularMovies = 'movie/popular';
  static const String topRatedMovies = 'movie/top_rated';
  static const String nowPlayingMovies = 'movie/now_playing';
  static const String upcomingMovies = 'movie/upcoming';

  // TV endpoints
  static const String popularTvShows = 'tv/popular';
  static const String topRatedTvShows = 'tv/top_rated';
  static const String onTheAirTvShows = 'tv/on_the_air';

  // Search endpoints
  static const String searchMovie = 'search/movie';
  static const String searchTv = 'search/tv';
  static const String searchPerson = 'search/person';
  static const String searchMulti = 'search/multi';

  // Detail endpoints
  static String movieDetails(int movieId) => 'movie/$movieId';
  static String tvDetails(int tvId) => 'tv/$tvId';
  static String personDetails(int personId) => 'person/$personId';

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
}
