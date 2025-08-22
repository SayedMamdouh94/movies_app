import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:movies_app/features/popular_people/presentation/cubit/popular_people_cubit.dart';
import '../../../helpers/mock_classes.dart';

void main() {
  group('PopularPeopleCubit', () {
    late PopularPeopleCubit cubit;
    late MockPopularPeopleRepo mockRepository;

    setUp(() {
      mockRepository = MockPopularPeopleRepo();
      cubit = PopularPeopleCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be PopularPeopleInitial', () {
      expect(cubit.state, isA<PopularPeopleInitial>());
    });

    group('loadPopularPeople', () {
      final mockPerson = PopularPersonModel.fromJson(MockData.mockPersonJson);
      final mockResponse = PopularPeopleResponseModel.fromJson(
        MockData.mockPopularPeopleResponseJson,
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'emits [Loading, Loaded] when data is fetched successfully',
        build: () {
          when(
            () => mockRepository.getPopularPeople(page: any(named: 'page')),
          ).thenAnswer((_) async => Success(mockResponse));
          when(
            () => mockRepository.hasOfflineData(),
          ).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.loadPopularPeople(),
        expect: () => [
          isA<PopularPeopleLoading>(),
          isA<PopularPeopleLoaded>()
              .having((state) => state.people.length, 'people length', 1)
              .having((state) => state.currentPage, 'current page', 1)
              .having((state) => state.totalPages, 'total pages', 100)
              .having((state) => state.hasReachedMax, 'has reached max', false),
        ],
        verify: (_) {
          verify(
            () => mockRepository.getPopularPeople(page: 1, forceRefresh: false),
          ).called(1);
        },
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'emits [Loading, Error] when repository throws error',
        build: () {
          when(
            () => mockRepository.getPopularPeople(page: any(named: 'page')),
          ).thenAnswer((_) async => Error('Network error'));
          when(
            () => mockRepository.hasOfflineData(),
          ).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.loadPopularPeople(),
        expect: () => [
          isA<PopularPeopleLoading>(),
          isA<PopularPeopleError>()
              .having(
                (state) => state.message,
                'error message',
                contains('Network error'),
              )
              .having((state) => state.currentPeople, 'current people', null),
        ],
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'loads offline data when network fails and offline data exists',
        build: () {
          when(
            () => mockRepository.getPopularPeople(page: 1),
          ).thenAnswer((_) async => Error('Network error'));
          when(
            () => mockRepository.getPopularPeople(
              page: 1,
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => Success(mockResponse));
          when(
            () => mockRepository.hasOfflineData(),
          ).thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) => cubit.loadPopularPeople(),
        expect: () => [
          isA<PopularPeopleLoading>(),
          isA<PopularPeopleLoaded>().having(
            (state) => state.isOfflineMode,
            'is offline mode',
            true,
          ),
        ],
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'refreshes data when refresh is true',
        build: () {
          when(
            () => mockRepository.getPopularPeople(
              page: any(named: 'page'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => Success(mockResponse));
          when(
            () => mockRepository.hasOfflineData(),
          ).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.loadPopularPeople(refresh: true),
        expect: () => [isA<PopularPeopleLoading>(), isA<PopularPeopleLoaded>()],
        verify: (_) {
          verify(
            () => mockRepository.getPopularPeople(page: 1, forceRefresh: true),
          ).called(1);
        },
      );
    });

    group('loadMorePeople', () {
      final mockResponse = PopularPeopleResponseModel.fromJson(
        MockData.mockPopularPeopleResponseJson,
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'loads more people when not at max',
        build: () {
          when(
            () => mockRepository.getPopularPeople(page: any(named: 'page')),
          ).thenAnswer((_) async => Success(mockResponse));
          when(
            () => mockRepository.hasOfflineData(),
          ).thenAnswer((_) async => false);
          return cubit;
        },
        seed: () => PopularPeopleLoaded(
          people: [PopularPersonModel.fromJson(MockData.mockPersonJson)],
          currentPage: 1,
          totalPages: 100,
          hasReachedMax: false,
          isOfflineMode: false,
        ),
        act: (cubit) => cubit.loadMorePeople(),
        expect: () => [
          isA<PopularPeopleLoadingMore>(),
          isA<PopularPeopleLoaded>(),
        ],
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'does not load more when max is reached',
        build: () => cubit,
        seed: () => PopularPeopleLoaded(
          people: [PopularPersonModel.fromJson(MockData.mockPersonJson)],
          currentPage: 100,
          totalPages: 100,
          hasReachedMax: true,
          isOfflineMode: false,
        ),
        act: (cubit) => cubit.loadMorePeople(),
        expect: () => [],
        verify: (_) {
          verifyNever(
            () => mockRepository.getPopularPeople(page: any(named: 'page')),
          );
        },
      );
    });

    group('refreshPeople', () {
      final mockResponse = PopularPeopleResponseModel.fromJson(
        MockData.mockPopularPeopleResponseJson,
      );

      blocTest<PopularPeopleCubit, PopularPeopleState>(
        'refreshes people successfully',
        build: () {
          when(
            () => mockRepository.getPopularPeople(
              page: any(named: 'page'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => Success(mockResponse));
          when(
            () => mockRepository.hasOfflineData(),
          ).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.refreshPeople(),
        expect: () => [isA<PopularPeopleLoading>(), isA<PopularPeopleLoaded>()],
        verify: (_) {
          verify(
            () => mockRepository.getPopularPeople(page: 1, forceRefresh: true),
          ).called(1);
        },
      );
    });
  });
}
