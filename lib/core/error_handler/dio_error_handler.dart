import 'package:dio/dio.dart';

class DioErrorHandler {
  /// Handles DioException and returns a user-friendly error message
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Response timeout. Please try again.';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.badCertificate:
        return 'Certificate error. Please try again.';
      case DioExceptionType.unknown:
        return 'Network error: ${error.message}';
    }
  }

  /// Handles bad response status codes
  static String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please check your API key.';
      case 403:
        return 'Access forbidden. You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 422:
        return 'Invalid data provided. Please check your input.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      case 504:
        return 'Gateway timeout. Please try again later.';
      default:
        return 'HTTP Error: $statusCode';
    }
  }

  /// Handles general exceptions and returns a user-friendly error message
  static String handleGeneralError(Object error) {
    if (error is DioException) {
      return handleDioError(error);
    }
    return 'An unexpected error occurred: ${error.toString()}';
  }
}
