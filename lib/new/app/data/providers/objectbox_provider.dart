import 'package:objectbox/objectbox.dart';

class ObjectboxProvider<T> {
  final Box<T> _box;

  const ObjectboxProvider({
    required Box<T> box,
  }) : _box = box;

  Future<int> insert(T entity) async {
    return await _box.putAsync(entity, mode: PutMode.insert);
  }

  Future<T?> findFirst(Condition<T> condition) async {
    return await _box.query(condition).build().findFirstAsync();
  }

  Stream<List<T>> stream() {
    final query = _box.query().watch(triggerImmediately: true);
    return query.map((query) => query.find());
  }
}
