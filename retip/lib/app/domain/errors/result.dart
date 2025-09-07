abstract class Result<T> {
  const Result();
}

class ResultSuccess<T> extends Result<T> {
  final T data;

  const ResultSuccess(this.data);
}

class ResultFailure<T> extends Result<T> {
  final Exception error;

  const ResultFailure(this.error);

  factory ResultFailure.fromObject(Object object) {
    final error = object is Exception ? object : Exception(object);

    return ResultFailure(error);
  }
}
