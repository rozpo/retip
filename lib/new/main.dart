import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import 'app/data/providers/app_settings_provider.dart';
import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/repositories/album_repository_i.dart';
import 'app/data/repositories/artist_repository_i.dart';
import 'app/data/repositories/genre_repository_i.dart';
import 'app/data/repositories/permission_repository_i.dart';
import 'app/data/repositories/track_repository_i.dart';
import 'app/domain/usecases/album_usecase.dart';
import 'app/domain/usecases/artist_usecase.dart';
import 'app/domain/usecases/genre_usecase.dart';
import 'app/domain/usecases/library_usecase.dart';
import 'app/domain/usecases/permission_usecase.dart';
import 'app/domain/usecases/track_usecase.dart';
import 'app/presentation/pages/permission/bloc/permission_bloc.dart';
import 'app/retip_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initObjectbox();

  // Third party dependencies
  final store = GetIt.I.get<Store>();

  // Providers initialization
  final appSettingsProvider = AppSettingsProvider();
  final objectboxProvider = ObjectboxProvider(
    store: store,
  );
  final onAudioQueryProvider = OnAudioQueryProvider();

  // Repositories initialization
  final artistRepository = ArtistRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );
  final albumRepository = AlbumRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );
  final genreRepository = GenreRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );
  final permissionRepository = PermissionRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    appSettingsProvider: appSettingsProvider,
  );
  final trackRepository = TrackRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  // Usecases initialization
  final albumUsecase = AlbumUsecase(
    albumRepository: albumRepository,
  );
  final artistUsecase = ArtistUsecase(
    artistRepository: artistRepository,
  );
  final genreUsecase = GenreUsecase(
    genreRepository: genreRepository,
  );
  final libraryUsecase = LibraryUsecase(
    artistRepository: artistRepository,
    albumRepository: albumRepository,
    genreRepository: genreRepository,
    trackRepository: trackRepository,
  );
  final permissionUsecase = PermissionUsecase(
    permissionRepository: permissionRepository,
  );
  final trackUsecase = TrackUsecase(
    trackRepository: trackRepository,
  );

  // Blocs initialization
  final permissionBloc = PermissionBloc(
    permissionUsecase: permissionUsecase,
  );

  // App initialization
  final retipApp = RetipApp(
    permissionUsecase: permissionUsecase,
    libraryUsecase: libraryUsecase,
    permissionBloc: permissionBloc,
    artistUsecase: artistUsecase,
    albumUsecase: albumUsecase,
    genreUsecase: genreUsecase,
    trackUsecase: trackUsecase,
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
