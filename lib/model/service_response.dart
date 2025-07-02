sealed class ServiceResult<T, E> {}

class SucessResult<T, E> extends ServiceResult<T, E> {
  final T data;
  SucessResult(this.data);
}

class FailureResult<T, E> extends ServiceResult<T, E> {
  final E error;
  final Exception? exceptions;
  FailureResult(this.error, {this.exceptions});
}
