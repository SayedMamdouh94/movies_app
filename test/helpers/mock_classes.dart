import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/popular_people/data/repo/popular_people_repo.dart';
import 'package:movies_app/features/popular_people/data/datasources/popular_people_local_data_source.dart';
import 'package:movies_app/core/data/local/database_manager.dart';
import 'package:movies_app/core/helpers/network_connectivity_helper.dart';
import 'package:movies_app/core/services/image_save_service.dart';

/// Mock classes for testing
class MockPopularPeopleRepo extends Mock implements PopularPeopleRepo {}

class MockPopularPeopleLocalDataSource extends Mock
    implements PopularPeopleLocalDataSource {}

class MockDatabaseManager extends Mock implements DatabaseManager {}

class MockNetworkConnectivityHelper extends Mock
    implements NetworkConnectivityHelper {}

class MockImageSaveService extends Mock implements ImageSaveService {}

/// Mock data for testing
class MockData {
  static const mockPersonJson = {
    'id': 1,
    'adult': false,
    'gender': 2,
    'name': 'John Doe',
    'profile_path': '/profile.jpg',
    'popularity': 85.5,
    'known_for_department': 'Acting',
    'known_for': [
      {
        'id': 123,
        'adult': false,
        'media_type': 'movie',
        'original_language': 'en',
        'original_title': 'Test Movie',
        'overview': 'A test movie',
        'poster_path': '/poster.jpg',
        'release_date': '2023-01-01',
        'title': 'Test Movie',
        'video': false,
        'vote_average': 8.5,
        'vote_count': 1000,
        'popularity': 100.0,
      },
    ],
  };

  static const mockPopularPeopleResponseJson = {
    'page': 1,
    'results': [mockPersonJson],
    'total_pages': 100,
    'total_results': 2000,
  };
}
