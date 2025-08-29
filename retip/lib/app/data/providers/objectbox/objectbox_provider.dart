import 'package:flutter/foundation.dart';

import 'objectbox.g.dart';

class ObjectboxProvider {
  final Store _store;
  // ignore: unused_field
  final Admin? _admin;

  ObjectboxProvider._(this._store, [this._admin]);

  static Future<ObjectboxProvider> init() async {
    final store = await openStore();
    Admin? admin;
    if (!kReleaseMode && Admin.isAvailable()) {
      admin = Admin(store);
    }

    return ObjectboxProvider._(store, admin);
  }

  Stream<List<T>> streamAll<T>() {
    final box = _store.box<T>();
    final stream = box.query().watch(triggerImmediately: true);

    return stream.map((query) => query.find());
  }

  Future<List<T>> getAll<T>() async {
    final box = _store.box<T>();

    return box.getAll();
  }

  Future<List<int>> insertMany<T>(List<T> objects) async {
    final box = _store.box<T>();

    return box.putMany(objects, mode: PutMode.insert);
  }
}
