import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import 'app/domain/repositories/library_repository.dart';
import 'app/retip_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initObjectbox();

  LibraryRepository().scan();

  runApp(const RetipApp());
}

Future<void> initObjectbox() async {
  // Objectbox setup
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'objectbox');

  late Store store;
  try {
    store = await openStore(directory: dbPath);
  } catch (e) {
    final dbFile = File(join(dbPath, 'data.mdb'));
    final lockFile = File(join(dbPath, 'lock.mdb'));

    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    if (await lockFile.exists()) {
      await lockFile.delete();
    }

    store = await openStore(directory: dbPath);
  } finally {
    GetIt.I.registerSingleton<Store>(store);

    if (kReleaseMode == false && Admin.isAvailable()) {
      GetIt.I.registerSingleton<Admin>(Admin(store));
    }
  }
}
