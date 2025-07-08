import 'package:flutter/foundation.dart';
import 'package:retip/objectbox.g.dart';

final class ObjectboxProvider {
  final Store _store;
  final Admin? _admin;

  static Future<ObjectboxProvider> init() async {
    Store store = await openStore();
    Admin? admin;

    if (kDebugMode && Admin.isAvailable()) {
      admin = Admin(store);
    }

    return ObjectboxProvider._(store, admin);
  }

  const ObjectboxProvider._(this._store, this._admin);

  void close() {
    _store.close();
    _admin?.close();
  }

  Future<List<T>> getAll<T>() async {
    return _store.box<T>().getAllAsync();
  }

  Future<List<int>> putMany<T>(List<T> objects) async {
    return await _store.box<T>().putManyAsync(objects);
  }

  Stream<List<T>> watchAll<T>() {
    return _store
        .box<T>()
        .query()
        .watch(triggerImmediately: true)
        .map((q) => q.find());
  }
}
