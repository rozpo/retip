abstract class Result<T> {
  const Result();
}

final class ResultSuccess<T> extends Result<T> {
  final T data;

  const ResultSuccess(this.data);
}

final class ResultFailure<T> extends Result<T> {
  final Exception error;

  const ResultFailure(this.error);
}
