import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../objectbox.g.dart';
import 'app/data/providers/app_settings_provider.dart';
import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/album_repository_i.dart';
import 'app/data/repositories/artist_repository_i.dart';
import 'app/data/repositories/config_repository_i.dart';
import 'app/data/repositories/genre_repository_i.dart';
import 'app/data/repositories/permission_repository_i.dart';
import 'app/data/repositories/track_repository_i.dart';
import 'app/domain/repositories/config_repository.dart';
import 'app/domain/usecases/album_usecase.dart';
import 'app/domain/usecases/artist_usecase.dart';
import 'app/domain/usecases/config_usecase.dart';
import 'app/domain/usecases/genre_usecase.dart';
import 'app/domain/usecases/library_usecase.dart';
import 'app/domain/usecases/permission_usecase.dart';
import 'app/domain/usecases/track_usecase.dart';
import 'app/presentation/pages/library/bloc/library_bloc.dart';
import 'app/presentation/pages/permission/bloc/permission_bloc.dart';
import 'app/retip_app.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Third party dependencies
  final prefs = await SharedPreferences.getInstance();
  final router = RetipRouter();
  final store = await initObjectbox();
  final theme = RetipTheme();

  // Providers initialization
  final appSettingsProvider = AppSettingsProvider();
  final objectboxProvider = ObjectboxProvider(
    store: store,
  );
  final onAudioQueryProvider = OnAudioQueryProvider();
  final sharedPreferencesProvider = SharedPreferencesProvider(
    sharedPreferences: prefs,
  );

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
  final ConfigRepository configRepository = ConfigRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
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
  final configUsecase = ConfigUsecase(
    configRepository: configRepository,
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
  final libraryBloc = LibraryBloc(
    libraryUsecase: libraryUsecase,
  );
  final permissionBloc = PermissionBloc(
    permissionUsecase: permissionUsecase,
  );

  // App initialization
  final retipApp = RetipApp(
    permissionUsecase: permissionUsecase,
    libraryUsecase: libraryUsecase,
    permissionBloc: permissionBloc,
    artistUsecase: artistUsecase,
    configUsecase: configUsecase,
    albumUsecase: albumUsecase,
    genreUsecase: genreUsecase,
    trackUsecase: trackUsecase,
    libraryBloc: libraryBloc,
    retipRouter: router,
    retipTheme: theme,
  );

  runApp(retipApp);
}

Future<Store> initObjectbox() async {
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

  return store;
}
