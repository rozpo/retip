import 'package:objectbox/objectbox.dart';

class ObjectboxProvider {
  final Store _store;

  const ObjectboxProvider({
    required Store store,
  }) : _store = store;

  Future<T?> get<T>(int id) async {
    return await _store.box<T>().getAsync(id);
  }

  Future<int> insert<T>(T entity) async {
    return await _store.box<T>().putAsync(entity, mode: PutMode.insert);
  }

  Future<int> update<T>(T entity) async {
    return await _store.box<T>().putAsync(entity, mode: PutMode.update);
  }

  Future<T?> findFirst<T>(Condition<T> condition) async {
    return await _store.box<T>().query(condition).build().findFirstAsync();
  }

  Stream<List<T>> stream<T>([Condition<T>? condition]) {
    final query =
        _store.box<T>().query(condition).watch(triggerImmediately: true);
    return query.map((query) => query.find());
  }
}
