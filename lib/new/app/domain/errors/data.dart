abstract class Data {
  const Data();
}

class DataSuccess<T> extends Data {
  final T data;

  const DataSuccess(this.data);
}

class DataError extends Data {
  final Object error;

  const DataError(this.error);
}
