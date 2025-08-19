sealed class DataResult<T> {
  const factory DataResult.success(T data) = Success;
  const factory DataResult.error(String message) = Error;
}

class Success<T> implements DataResult<T> {
  final T data;

  const Success(this.data);
}

class Error<T> implements DataResult<T> {
  final String message;

  const Error(this.message);
}
