import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/local_secure_storage/local_storage.dart';
import 'package:movies_app/core/networking/api_constants.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/core/router/app_navigator.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/features/login/data/models/login_response_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static bool _isRefreshing = false;
  static final List<RequestOptions> _failedQueue = [];

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
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await LocalSecureStorage.accessToken;
            options.headers['Authorization'] = token;
            handler.next(options);
          },
          onResponse: (response, handler) {
            handler.next(response);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              await _handle401Error(e, handler);
            } else {
              handler.next(e);
            }
          },
        ),
      );
    return dio!;
  }

  static Future<void> _handle401Error(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = error.requestOptions;

    if (_isRefreshing) {
      // If already refreshing, add to queue
      _failedQueue.add(requestOptions);
      return;
    }

    _isRefreshing = true;
    try {
      // Attempt to refresh token
      final refreshTokenResult = await _refreshToken();
      switch (refreshTokenResult) {
        case Success():
          await LocalSecureStorage.saveTokens(
            accessToken: refreshTokenResult.data.data?.accessToken ?? '',
            refreshToken: refreshTokenResult.data.data?.refreshToken ?? '',
            userId: refreshTokenResult.data.data?.userId ?? '',
          );
          final newToken = refreshTokenResult.data.data?.accessToken;
          log('New access token: $newToken');
          requestOptions.headers['Authorization'] = 'Bearer $newToken';

          // Retry the original request
          final response = await dio!.fetch(requestOptions);
          handler.resolve(response);

          // Process queued requests
          await _processFailedQueue();
        case Error():
          await _handleRefreshFailure();
          handler.next(error);
      }
    } catch (e) {
      await _handleRefreshFailure();
      handler.next(error);
    } finally {
      _isRefreshing = false;
      _failedQueue.clear();
    }
  }

  static Future<DataResult<LoginResponseModel>> _refreshToken() async {
    try {
      final refreshToken = await LocalSecureStorage.refreshToken;
      final userId = await LocalSecureStorage.userId;

      if (userId == null) {
        return const DataResult.error(
          'User is not available. Please log in again.',
        );
      }
      final refreshDio = Dio();
      refreshDio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
      final response = await refreshDio.post(
        '${ApiConstants.baseUrl}${ApiConstants.refreshToken}',
        data: {'userId': userId, 'refreshToken': refreshToken},
      );

      final refreshTokenResponse = LoginResponseModel.fromJson(response.data);
      if (refreshTokenResponse.data?.accessToken == null) {
        return const DataResult.error(
          'Failed to refresh token. Please log in again.',
        );
      }
      if (refreshTokenResponse.success) {
        log('Token refreshed successfully');
        return DataResult.success(refreshTokenResponse);
      }
      return const DataResult.error(
          'Failed to refresh token. Please log in again.');
    } on DioException catch (e) {
      return DataResult.error(
        e.message ?? 'An error occurred while refreshing token',
      );
    } catch (e) {
      return const DataResult.error('An unexpected error occurred');
    }
  }

  static Future<void> _processFailedQueue() async {
    final newToken = await LocalSecureStorage.accessToken;

    for (final requestOptions in _failedQueue) {
      try {
        requestOptions.headers['Authorization'] = 'Bearer $newToken';
        await dio!.fetch(requestOptions);
      } catch (_) {}
    }
  }

  static Future<void> _handleRefreshFailure() async {
    await LocalSecureStorage.clearAllData;
    navigator.currentContext?.pushNamedAndRemoveUntil(Routes.intro);
  }
}
