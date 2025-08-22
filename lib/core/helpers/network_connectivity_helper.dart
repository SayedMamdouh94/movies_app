import 'dart:io';
import 'package:flutter/foundation.dart';

class NetworkConnectivityHelper {
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      debugPrint('No internet connection: $e');
      return false;
    } catch (e) {
      debugPrint('Error checking internet connection: $e');
      return false;
    }
  }

  static Future<bool> canReachTmdbApi() async {
    try {
      final result = await InternetAddress.lookup('api.themoviedb.org');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      debugPrint('Cannot reach TMDB API: $e');
      return false;
    } catch (e) {
      debugPrint('Error checking TMDB API connectivity: $e');
      return false;
    }
  }
}
