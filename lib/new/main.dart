import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/repositories/library_repository_i.dart';
import 'app/data/repositories/track_repository_i.dart';
import 'app/domain/usecases/scan_library_usecase.dart';
import 'app/domain/usecases/tracks_stream_usecase.dart';
import 'app/retip_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initObjectbox();

  // Third party dependencies
  final store = GetIt.I.get<Store>();
  final onAudioQuery = OnAudioQuery();

  // Providers initialization
  final onAudioQueryProvider = OnAudioQueryProvider(
    onAudioQuery: onAudioQuery,
  );
  final objectboxProvider = ObjectboxProvider(
    store: store,
  );

  // Repositories initialization
  final libraryRepository = LibraryRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );
  final trackRepository = TrackRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  // Usecases initialization
  final scanLibraryUsecase = ScanLibraryUsecase(
    libraryRepository: libraryRepository,
    trackRepository: trackRepository,
  )..call();
  final tracksStreamUsecase = TracksStreamUsecase(
    libraryRepository: libraryRepository,
  );

  // App initialization
  final retipApp = RetipApp(
    tracksStreamUsecase: tracksStreamUsecase,
    scanLibraryUsecase: scanLibraryUsecase,
  );

  runApp(retipApp);
}

Future<void> initObjectbox() async {
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
