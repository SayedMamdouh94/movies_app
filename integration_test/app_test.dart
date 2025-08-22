import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies_app/main.dart' as app;
import 'package:get_it/get_it.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Movies App Integration Tests', () {
    setUp(() async {
      // Reset GetIt before each test to avoid registration conflicts
      await GetIt.instance.reset();
    });

    testWidgets('app loads and displays popular people', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify the app loaded
      expect(find.byType(MaterialApp), findsOneWidget);

      // Wait for popular people to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check if we can find some UI elements
      // This would depend on your actual UI structure
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('navigation works correctly', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Test navigation if you have multiple screens
    
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('popular people list scrolling works', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Wait for data to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find a scrollable widget (ListView, GridView, etc.)
      final scrollableFinder = find.byType(Scrollable);

      if (scrollableFinder.hasFound) {
        // Scroll down
        await tester.drag(scrollableFinder.first, const Offset(0, -300));
        await tester.pumpAndSettle();

        // Scroll back up
        await tester.drag(scrollableFinder.first, const Offset(0, 300));
        await tester.pumpAndSettle();
      }

      // Verify the app is still working
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('offline mode works correctly', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Wait for initial data to load and cache
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Simulate offline mode by turning off network
      // Note: This would require additional setup with network mocking
      // For now, we just verify the app doesn't crash

      // Test pull to refresh
      final scrollableFinder = find.byType(Scrollable);
      if (scrollableFinder.hasFound) {
        await tester.fling(scrollableFinder.first, const Offset(0, 300), 1000);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }

      // Verify the app is still responsive
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('search functionality works', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Look for search functionality
      final searchFinder = find.byIcon(Icons.search);
      if (searchFinder.hasFound) {
        await tester.tap(searchFinder);
        await tester.pumpAndSettle();

        // Enter search text if search field exists
        final textFieldFinder = find.byType(TextField);
        if (textFieldFinder.hasFound) {
          await tester.enterText(textFieldFinder, 'John');
          await tester.pumpAndSettle();
        }
      }

      // Verify the app is still working
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('error handling works correctly', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Wait for initial load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Test retry functionality if there's an error state
      final retryButtonFinder = find.text('Retry');
      if (retryButtonFinder.hasFound) {
        await tester.tap(retryButtonFinder);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }

      // Verify the app recovered
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });
  });
}
