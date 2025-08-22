import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecureStorage {
  static late FlutterSecureStorage _secureStorage;
  static const String _accessToken = 'access_token';
  static const String _refreshToken = 'refresh_token';

  LocalSecureStorage._();

  static Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    // Optionally, you can set the storage options here
  }

  static Future<void> setAccessToken(String? value) async {
    await _secureStorage.delete(key: _accessToken);
    if (value != null) {
      await _secureStorage.write(key: _accessToken, value: 'Bearer $value');
    }
  }

  static Future<void> setRefreshToken(String? value) async {
    await _secureStorage.write(key: _refreshToken, value: value);
  }

  static Future<void> setUserId(String? value) async {
    await _secureStorage.write(key: 'user_id', value: value);
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String userId,
  }) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
    await setUserId(userId);
  }

  static Future<String> get accessToken async =>
      await _secureStorage.read(key: _accessToken) ?? '';

  static Future<String> get refreshToken async =>
      await _secureStorage.read(key: _refreshToken) ?? '';

  static Future<String?> get userId async =>
      await _secureStorage.read(key: 'user_id');

  static Future<void> get clearAllData async =>
      await _secureStorage.deleteAll();

  // Method to save TMDB API key for API usage
  static Future<void> saveTmdbToken() async {
    const String tmdbApiKey = '66ed44846adddce0ed5fcaf0648b4e0b';
    // Clear any existing tokens first
    await _secureStorage.delete(key: 'tmdb_api_key');
    await _secureStorage.delete(key: _accessToken);
    // Save the new API key
    await _secureStorage.write(key: 'tmdb_api_key', value: tmdbApiKey);
  }

  static Future<String> get tmdbApiKey async {
    final apiKey = await _secureStorage.read(key: 'tmdb_api_key');
    return apiKey ?? '66ed44846adddce0ed5fcaf0648b4e0b';
  }
}
