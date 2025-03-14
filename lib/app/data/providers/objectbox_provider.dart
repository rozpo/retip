import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../objectbox.g.dart' as g;

class ObjectboxProvider {
  final Store _store;
  // ignore: unused_field
  final Admin? _admin;

  ObjectboxProvider._(
    Store store,
    Admin? admin,
  )   : _store = store,
        _admin = admin;

  static Future<ObjectboxProvider> init() async {
    Store? store;
    Admin? admin;

    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, 'objectbox');

    try {
      store = await g.openStore(directory: dbPath);
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

    try {
      // Try to open the store again if it failed
      store ??= await g.openStore(directory: dbPath);

      // Activate admin if not in release mode
      if (kReleaseMode == false && Admin.isAvailable()) {
        admin = Admin(store);
      }
    } catch (e) {
      // Database still fails to open
      throw Exception('Failed to open Objectbox store');
    }

    return ObjectboxProvider._(store, admin);
  }

  Future<List<T>> getAll<T>() async {
    return await _store.box<T>().getAllAsync();
  }

  Future<T?> get<T>(int id) async {
    return await _store.box<T>().getAsync(id);
  }

  Future<List<T?>> getMany<T>(List<int> ids) async {
    return await _store.box<T>().getManyAsync(ids);
  }

  Future<List<int>> insertMany<T>(List<T> entities) async {
    return await _store.box<T>().putManyAsync(entities, mode: PutMode.insert);
  }

  Future<int> insert<T>(T entity) async {
    return await _store.box<T>().putAsync(entity, mode: PutMode.insert);
  }

  Future<int> update<T>(T entity) async {
    return await _store.box<T>().putAsync(entity, mode: PutMode.update);
  }

  Future<bool> remove<T>(int id) async {
    return await _store.box<T>().removeAsync(id);
  }

  Stream<List<T>> stream<T>([Condition<T>? condition]) {
    return _store
        .box<T>()
        .query(condition)
        .watch(triggerImmediately: true)
        .map((query) {
      return query.find();
    });
  }

  Stream<T?> streamFirst<T>([Condition<T>? condition]) {
    return _store
        .box<T>()
        .query(condition)
        .watch(triggerImmediately: true)
        .map((query) {
      return query.findFirst();
    });
  }

  Future<T?> findFirst<T>(Condition<T> condition) async {
    return await _store.box<T>().query(condition).build().findFirstAsync();
  }
}
