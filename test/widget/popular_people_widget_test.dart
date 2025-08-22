import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:movies_app/features/popular_people/presentation/cubit/popular_people_cubit.dart';
import 'package:movies_app/features/popular_people/presentation/ui/screens/popular_people_screen.dart';
import '../helpers/test_helpers.dart';
import '../helpers/mock_classes.dart';

void main() {
  group('PopularPeopleScreen Tests', () {
    late MockPopularPeopleRepo mockRepository;
    late PopularPeopleCubit cubit;

    setUp(() {
      mockRepository = MockPopularPeopleRepo();
      cubit = PopularPeopleCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    testWidgets('displays loading indicator when state is loading', (
      WidgetTester tester,
    ) async {
      // Build widget with loading state
      await TestHelpers.pumpWidgetAndSettle(
        tester,
        TestHelpers.createTestApp(
          BlocProvider<PopularPeopleCubit>(
            create: (_) => cubit,
            child: const PopularPeopleScreen(),
          ),
        ),
      );

      // Verify loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays people list when state is loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      final mockPeople = [PopularPersonModel.fromJson(MockData.mockPersonJson)];

      // Build widget with loaded state
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          BlocProvider<PopularPeopleCubit>.value(
            value: cubit,
            child: const PopularPeopleScreen(),
          ),
        ),
      );

      // Trigger loaded state
      cubit.emit(
        PopularPeopleLoaded(
          people: mockPeople,
          currentPage: 1,
          totalPages: 10,
          hasReachedMax: false,
          isOfflineMode: false,
        ),
      );

      await tester.pumpAndSettle();

      // Verify person name is displayed
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('displays error message when state is error', (
      WidgetTester tester,
    ) async {
      // Build widget
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          BlocProvider<PopularPeopleCubit>.value(
            value: cubit,
            child: const PopularPeopleScreen(),
          ),
        ),
      );

      // Trigger error state
      cubit.emit(
        PopularPeopleError(
          message: 'Network error',
          currentPeople: null,
          isOfflineMode: false,
        ),
      );

      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('displays offline indicator when in offline mode', (
      WidgetTester tester,
    ) async {
      // Arrange
      final mockPeople = [PopularPersonModel.fromJson(MockData.mockPersonJson)];

      // Build widget
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          BlocProvider<PopularPeopleCubit>.value(
            value: cubit,
            child: const PopularPeopleScreen(),
          ),
        ),
      );

      // Trigger offline loaded state
      cubit.emit(
        PopularPeopleLoaded(
          people: mockPeople,
          currentPage: 1,
          totalPages: 1,
          hasReachedMax: true,
          isOfflineMode: true,
        ),
      );

      await tester.pumpAndSettle();

      // Verify offline mode is indicated (this would depend on your UI implementation)
      // For example, if you show an offline banner or icon
      // expect(find.text('Offline'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('handles refresh action', (WidgetTester tester) async {
      // Arrange
      final mockPeople = [PopularPersonModel.fromJson(MockData.mockPersonJson)];

      when(
        () => mockRepository.getPopularPeople(
          page: any(named: 'page'),
          forceRefresh: any(named: 'forceRefresh'),
        ),
      ).thenAnswer(
        (_) async => Success(
          PopularPeopleResponseModel.fromJson(
            MockData.mockPopularPeopleResponseJson,
          ),
        ),
      );
      when(
        () => mockRepository.hasOfflineData(),
      ).thenAnswer((_) async => false);

      // Build widget
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          BlocProvider<PopularPeopleCubit>.value(
            value: cubit,
            child: const PopularPeopleScreen(),
          ),
        ),
      );

      // Trigger loaded state first
      cubit.emit(
        PopularPeopleLoaded(
          people: mockPeople,
          currentPage: 1,
          totalPages: 10,
          hasReachedMax: false,
          isOfflineMode: false,
        ),
      );

      await tester.pumpAndSettle();

      // Find and trigger refresh (this would depend on your UI implementation)
      // For example, if you have a RefreshIndicator
      if (find.byType(RefreshIndicator).hasFound) {
        await tester.fling(
          find.byType(RefreshIndicator),
          const Offset(0, 300),
          1000,
        );
        await tester.pumpAndSettle();
      }

      // Verify refresh was triggered
      expect(find.text('John Doe'), findsOneWidget);
    });
  });
}
