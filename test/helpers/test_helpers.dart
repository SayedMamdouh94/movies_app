import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/di/dependency_injection.dart';

/// Test helper utilities for setting up test environment
class TestHelpers {
  /// Sets up GetIt dependencies for testing
  static void setupTestDependencies() {
    if (GetIt.instance.isRegistered<Object>()) {
      GetIt.instance.reset();
    }
    setupGetIt();
  }

  /// Creates a test app wrapper with material app
  static Widget createTestApp(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  /// Creates a test app with theme and localization
  static Widget createTestAppWithTheme(Widget child) {
    return MaterialApp(
      title: 'Movies App Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansArabic',
      ),
      home: Scaffold(body: child),
    );
  }

  /// Pumps widget and settles
  static Future<void> pumpWidgetAndSettle(
    WidgetTester tester,
    Widget widget,
  ) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  /// Finds widget by key and verifies it exists
  static void verifyWidgetExists(String key) {
    expect(find.byKey(Key(key)), findsOneWidget);
  }

  /// Finds widget by text and verifies it exists
  static void verifyTextExists(String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Taps widget by key
  static Future<void> tapWidgetByKey(WidgetTester tester, String key) async {
    await tester.tap(find.byKey(Key(key)));
    await tester.pumpAndSettle();
  }

  /// Scrolls to find a widget
  static Future<void> scrollToWidget(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(finder, 100.0);
    await tester.pumpAndSettle();
  }
}
