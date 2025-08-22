import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:movies_app/features/popular_people/data/repo/popular_people_repo.dart';
import 'package:movies_app/features/popular_people/data/apis/popular_people_api_service.dart';
import '../../../helpers/mock_classes.dart';

class MockPopularPeopleApiService extends Mock
    implements PopularPeopleApiService {}

void main() {
  group('PopularPeopleRepo', () {
    late PopularPeopleRepo repository;
    late MockPopularPeopleApiService mockApiService;
    late MockPopularPeopleLocalDataSource mockLocalDataSource;

    setUp(() {
      mockApiService = MockPopularPeopleApiService();
      mockLocalDataSource = MockPopularPeopleLocalDataSource();
      repository = PopularPeopleRepo(mockApiService, mockLocalDataSource);
    });

    group('Repository Structure', () {
      test('should be instantiated with dependencies', () {
        // Verify that the repository can be created with its dependencies
        expect(repository, isA<PopularPeopleRepo>());
      });

      test('should have correct method signatures', () {
        // Test that the repository has the expected methods
        expect(repository.getPopularPeople, isA<Function>());
        expect(repository.hasOfflineData, isA<Function>());
        expect(repository.isCacheExpired, isA<Function>());
      });
    });

    group('Data Source Integration', () {
      test('should work with local data source methods', () async {
        // Arrange
        final mockPeople = [
          PopularPersonModel.fromJson(MockData.mockPersonJson),
        ];
        when(
          () => mockLocalDataSource.getAllCachedPeople(),
        ).thenAnswer((_) async => mockPeople);

        // Act
        final result = await repository.hasOfflineData();

        // Assert
        expect(result, true);
        verify(() => mockLocalDataSource.getAllCachedPeople()).called(1);
      });

      test('should handle empty cached data', () async {
        // Arrange
        when(
          () => mockLocalDataSource.getAllCachedPeople(),
        ).thenAnswer((_) async => <PopularPersonModel>[]);

        // Act
        final result = await repository.hasOfflineData();

        // Assert
        expect(result, false);
        verify(() => mockLocalDataSource.getAllCachedPeople()).called(1);
      });

      test('should check cache expiration', () async {
        // Arrange
        when(
          () => mockLocalDataSource.isCacheExpired(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await repository.isCacheExpired();

        // Assert
        expect(result, false);
        verify(() => mockLocalDataSource.isCacheExpired()).called(1);
      });
    });

    group('Mock Data Validation', () {
      test('should create valid PopularPersonModel from mock data', () {
        // Test that our mock data creates valid models
        final person = PopularPersonModel.fromJson(MockData.mockPersonJson);

        expect(person.id, 1);
        expect(person.name, 'John Doe');
        expect(person.knownForDepartment, 'Acting');
        expect(person.adult, false);
        expect(person.gender, 2);
        expect(person.popularity, 85.5);
      });

      test('should create valid PopularPeopleResponseModel from mock data', () {
        // Test that our mock response data creates valid models
        final response = PopularPeopleResponseModel.fromJson(
          MockData.mockPopularPeopleResponseJson,
        );

        expect(response.page, 1);
        expect(response.results.length, 1);
        expect(response.totalPages, 100);
        expect(response.totalResults, 2000);
      });
    });
  });
}
