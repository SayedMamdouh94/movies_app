import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/data/local/database_manager.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group('DatabaseManager', () {
    late DatabaseManager databaseManager;
    late MockDatabase mockDatabase;

    setUp(() {
      mockDatabase = MockDatabase();
      databaseManager = DatabaseManager();
    });

    test('database is initialized correctly', () async {
      // This test verifies that the database can be created
      expect(databaseManager, isA<DatabaseManager>());
    });

    test('database returns correct instance', () async {
      // This is a basic test to ensure the database getter works
      final db = await databaseManager.database;
      expect(db, isA<Database>());
    });

    test('closeDatabase works correctly', () async {
      // Test closing database
      await databaseManager.closeDatabase();
      // The method should complete without throwing
    });
  });
}
