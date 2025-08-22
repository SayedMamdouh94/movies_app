import 'dart:convert';
import 'package:movies_app/core/data/local/database_manager.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:sqflite/sqflite.dart';

class PopularPeopleLocalDataSource {
  final DatabaseManager _databaseManager;

  PopularPeopleLocalDataSource(this._databaseManager);

  Future<void> savePopularPeople({
    required List<PopularPersonModel> people,
    required int page,
  }) async {
    final db = await _databaseManager.database;
    final batch = db.batch();
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    // Delete existing data for this page before inserting new data
    batch.delete('popular_people', where: 'page = ?', whereArgs: [page]);

    // Insert new data
    for (final person in people) {
      batch.insert('popular_people', {
        'id': person.id,
        'adult': person.adult ? 1 : 0,
        'gender': person.gender,
        'known_for_department': person.knownForDepartment,
        'name': person.name,
        'popularity': person.popularity,
        'profile_path': person.profilePath,
        'known_for': jsonEncode(
          person.knownFor.map((k) => k.toJson()).toList(),
        ),
        'page': page,
        'created_at': currentTime,
        'updated_at': currentTime,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit();
  }

  Future<List<PopularPersonModel>> getPopularPeople({required int page}) async {
    final db = await _databaseManager.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'popular_people',
      where: 'page = ?',
      whereArgs: [page],
      orderBy: 'popularity DESC',
    );

    return maps.map((map) => _mapToPopularPersonModel(map)).toList();
  }

  Future<List<PopularPersonModel>> getAllCachedPeople() async {
    final db = await _databaseManager.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'popular_people',
      orderBy: 'page ASC, popularity DESC',
    );

    return maps.map((map) => _mapToPopularPersonModel(map)).toList();
  }

  Future<bool> hasDataForPage(int page) async {
    final db = await _databaseManager.database;

    final List<Map<String, dynamic>> result = await db.query(
      'popular_people',
      where: 'page = ?',
      whereArgs: [page],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<bool> isCacheExpired({int maxAgeInHours = 24}) async {
    final db = await _databaseManager.database;

    final List<Map<String, dynamic>> result = await db.query(
      'popular_people',
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (result.isEmpty) return true;

    final createdAt = result.first['created_at'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;
    final ageInHours = (now - createdAt) / (1000 * 60 * 60);

    return ageInHours > maxAgeInHours;
  }

  Future<void> clearAllData() async {
    final db = await _databaseManager.database;
    await db.delete('popular_people');
  }

  Future<void> clearDataForPage(int page) async {
    final db = await _databaseManager.database;
    await db.delete('popular_people', where: 'page = ?', whereArgs: [page]);
  }

  Future<int> getMaxCachedPage() async {
    final db = await _databaseManager.database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT MAX(page) as max_page FROM popular_people',
    );

    return result.first['max_page'] as int? ?? 0;
  }

  PopularPersonModel _mapToPopularPersonModel(Map<String, dynamic> map) {
    final knownForJson = jsonDecode(map['known_for'] as String) as List;
    final knownFor = knownForJson
        .map((k) => PopularPersonKnownForModel.fromJson(k))
        .toList();

    return PopularPersonModel(
      id: map['id'] as int,
      adult: (map['adult'] as int) == 1,
      gender: map['gender'] as int,
      knownForDepartment: map['known_for_department'] as String,
      name: map['name'] as String,
      popularity: map['popularity'] as double,
      profilePath: map['profile_path'] as String?,
      knownFor: knownFor,
    );
  }
}
