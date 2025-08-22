import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class DatabaseManager {
  static DatabaseManager? _instance;
  static Database? _database;

  DatabaseManager._internal();

  factory DatabaseManager() {
    _instance ??= DatabaseManager._internal();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'movies_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createPopularPeopleTable(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database schema upgrades here
    debugPrint('Database upgraded from version $oldVersion to $newVersion');
  }

  Future<void> _createPopularPeopleTable(Database db) async {
    await db.execute('''
      CREATE TABLE popular_people (
        id INTEGER PRIMARY KEY,
        adult INTEGER NOT NULL,
        gender INTEGER NOT NULL,
        known_for_department TEXT NOT NULL,
        name TEXT NOT NULL,
        popularity REAL NOT NULL,
        profile_path TEXT,
        known_for TEXT NOT NULL,
        page INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Create index for faster queries
    await db.execute('''
      CREATE INDEX idx_popular_people_page ON popular_people(page)
    ''');

    await db.execute('''
      CREATE INDEX idx_popular_people_created_at ON popular_people(created_at)
    ''');
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
