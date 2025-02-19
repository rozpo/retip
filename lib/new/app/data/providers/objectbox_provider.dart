import 'package:objectbox/objectbox.dart';

class ObjectboxProvider {
  final Store _store;

  const ObjectboxProvider({
    required Store store,
  }) : _store = store;

  Future<int> insert<T>(T entity) async {
    return await _store.box<T>().putAsync(entity, mode: PutMode.insert);
  }

  Future<T?> findFirst<T>(Condition<T> condition) async {
    return await _store.box<T>().query(condition).build().findFirstAsync();
  }

  Stream<List<T>> stream<T>() {
    final query = _store.box<T>().query().watch(triggerImmediately: true);
    return query.map((query) => query.find());
  }
}
