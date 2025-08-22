import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/di/dependency_injection.dart';
import 'package:movies_app/core/local_secure_storage/local_storage.dart';
import 'package:movies_app/firebase_options.dart';

import 'movies_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Lock device orientation to portrait only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await LocalStorage.init();
  setupGetIt();
  await LocalSecureStorage.init();

  // Save TMDB API key for API usage
  await LocalSecureStorage.saveTmdbToken();

  runApp(const MoviesApp());
}
