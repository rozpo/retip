import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    Store? store;
    Admin? admin;

    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = appDir.path;

    try {
      store = await openStore(directory: dbPath);
    } catch (e) {
      // Delete the database if it fails to open
      final dbFile = File(join(dbPath, 'data.mdb'));
      final lockFile = File(join(dbPath, 'lock.mdb'));

      if (await dbFile.exists()) {
        await dbFile.delete();
      }

      if (await lockFile.exists()) {
        await lockFile.delete();
      }
    }

    store ??= await openStore(directory: dbPath);
    admin = kReleaseMode == false && Admin.isAvailable() ? Admin(store) : null;

    return ObjectboxProvider._(store, admin);
  }

  void close() {
    _admin?.close();
    _store.close();
  }

  Future<List<T>> getAll<T>() async {
    return await _store.box<T>().getAllAsync();
  }

  Future<T?> get<T>(int id) async {
    return await _store.box<T>().getAsync(id);
  }

  Future<int> insert<T>(T entity) async {
    return _store.box<T>().putAsync(entity, mode: PutMode.insert);
  }

  Future<int> update<T>(T entity) async {
    return _store.box<T>().putAsync(entity, mode: PutMode.update);
  }

  Future<bool> delete<T>(int id) async {
    return _store.box<T>().removeAsync(id);
  }

  Future<List<int>> insertMany<T>(List<T> entites) async {
    return _store.box<T>().putManyAsync(entites, mode: PutMode.insert);
  }

  Stream<List<T>> watchAll<T>() {
    final box = _store.box<T>();
    final query = box.query();

    return query.watch(triggerImmediately: true).map((q) => q.find());
  }

  Stream<List<T>> watchWhere<T>([Condition<T>? condition]) {
    final box = _store.box<T>();
    final query = box.query(condition);

    return query.watch(triggerImmediately: true).map((q) => q.find());
  }

  Stream<T> watchWhereFirst<T>([Condition<T>? condition]) {
    final box = _store.box<T>();
    final query = box.query(condition);

    return query.watch(triggerImmediately: true).map((q) => q.findFirst()!);
  }
}
