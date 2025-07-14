import '../../../objectbox.g.dart';

class ObjectboxProvider {
  final Store _store;
  final Admin? _admin;

  const ObjectboxProvider._(
    Store store,
    Admin? admin,
  )   : _store = store,
        _admin = admin;

  static Future<ObjectboxProvider> init() async {
    final store = await openStore();
    final admin = Admin.isAvailable() ? Admin(store) : null;

    return ObjectboxProvider._(store, admin);
  }

  void close() {
    _admin?.close();
    _store.close();
  }

  Future<List<T>> getAll<T>() async {
    return await _store.box<T>().getAllAsync();
  }

  Future<List<int>> insertMany<T>(List<T> entites) async {
    return _store.box<T>().putManyAsync(entites, mode: PutMode.insert);
  }

  Stream<List<T>> watchAll<T>() {
    final box = _store.box<T>();
    return box.query().watch(triggerImmediately: true).map((q) => q.find());
  }
}
