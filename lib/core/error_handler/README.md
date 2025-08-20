# Error Handler

This module provides centralized error handling for the entire application, particularly for Dio HTTP errors.

## Usage

### DioErrorHandler

The `DioErrorHandler` class provides static methods to handle network errors consistently across the application.

#### Methods

- `handleDioError(DioException error)` - Handles Dio-specific errors and returns user-friendly messages
- `handleGeneralError(Object error)` - Handles any error type, including Dio errors and general exceptions

#### Example Usage

```dart
import 'package:movies_app/core/error_handler/error_handler.dart';

// In your repository
try {
  final result = await _apiService.getData();
  return DataResult.success(result);
} on DioException catch (e) {
  return DataResult.error(DioErrorHandler.handleDioError(e));
} catch (e) {
  return DataResult.error(DioErrorHandler.handleGeneralError(e));
}
```

#### Supported Error Types

- **Connection Timeout**: Network connection timeout
- **Send/Receive Timeout**: Request/response timeout
- **Bad Response**: HTTP status code errors (400, 401, 403, 404, 422, 429, 500, 502, 503, 504)
- **Connection Error**: No internet connection
- **Bad Certificate**: SSL/TLS certificate issues
- **Request Cancelled**: User cancelled the request
- **Unknown**: General network errors

#### Benefits

1. **Consistency**: All API errors are handled the same way across the app
2. **Maintainability**: Error messages can be updated in one place
3. **User Experience**: Provides clear, actionable error messages
4. **Reusability**: Can be used in any feature that makes HTTP requests

## Future Features that can use this handler

When creating new features that make API calls, always use the centralized error handler:

```dart
// In any repository class
import 'package:movies_app/core/error_handler/error_handler.dart';

class YourFeatureRepo {
  Future<DataResult<YourModel>> fetchData() async {
    try {
      final result = await _apiService.fetchData();
      return DataResult.success(result);
    } on DioException catch (e) {
      return DataResult.error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return DataResult.error(DioErrorHandler.handleGeneralError(e));
    }
  }
}
```
