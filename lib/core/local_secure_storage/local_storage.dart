import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  LocalStorage._();

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setLanguage(String language) async {
    await _sharedPreferences.setString('language', language);
  }

  static String get getLanguage =>
      _sharedPreferences.getString('language') ?? 'ar';
}
