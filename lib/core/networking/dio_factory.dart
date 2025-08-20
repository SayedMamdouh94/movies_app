import 'package:dio/dio.dart';
import 'package:movies_app/core/local_secure_storage/local_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio init() {
    final language = LocalStorage.getLanguage;
    Duration timeout = const Duration(seconds: 120);
    dio ??= Dio()
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': language,
      }
      ..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    return dio!;
  }
}
