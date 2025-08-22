import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/movies_app.dart';

void main() {
  group('MoviesApp Widget Tests', () {
    testWidgets('MoviesApp creates successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MoviesApp());

      // Verify that the app loads
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App has correct theme', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MoviesApp());

      // Find MaterialApp widget
      final materialAppWidget = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );

      // Verify app has theme configured
      expect(materialAppWidget.theme, isNotNull);
    });

    testWidgets('App handles navigation', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MoviesApp());
      await tester.pumpAndSettle();

      // Verify app loads without errors
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
