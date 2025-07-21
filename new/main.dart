import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'app/data/providers/just_audio_provider.dart';
import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/album_repository.dart';
import 'app/data/repositories/artist_repository.dart';
import 'app/data/repositories/audio_repository.dart';
import 'app/data/repositories/config_repository.dart';
import 'app/data/repositories/genre_repository.dart';
import 'app/data/repositories/permissions_repository.dart';
import 'app/data/repositories/playlist_repository.dart';
import 'app/data/repositories/track_repository.dart';
import 'app/domain/services/album_service.dart';
import 'app/domain/services/audio_service.dart';
import 'app/domain/services/library_service.dart';
import 'app/domain/services/onboarding_service.dart';
import 'app/domain/services/permissions_service.dart';
import 'app/domain/services/playlist_service.dart';
import 'app/presentation/blocs/audio/audio_bloc.dart';
import 'app/presentation/blocs/library/library_bloc.dart';
import 'app/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'app/presentation/blocs/permissions/permissions_bloc.dart';
import 'app/retip_app.dart';
import 'core/logger/retip_logger.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Logger
  final logger = GetIt.instance.registerSingleton(RetipLogger());
  logger.info('App starting...');

  // Core
  final router = RetipRouter();
  final theme = RetipTheme();

  // Providers
  final sharedPreferencesProvider = await SharedPreferencesProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();
  final objectboxProvider = await ObjectboxProvider.init();
  final justAudioProvider = await JustAudioProvider.init();

  // Repositories
  final permissionsRepository = PermissionsRepository(
    onAudioQueryProvider: onAudioQueryProvider,
  );

  final configRepository = ConfigRepository(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  final audioRepository = AudioRepository(
    justAudioProvider: justAudioProvider,
  );

  final genreRepository = GenreRepository(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final artistRepository = ArtistRepository(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final albumRepository = AlbumRepository(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final trackRepository = TrackRepository(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final playlistRepository = PlaylistRepository(
    objectboxProvider: objectboxProvider,
  );

  // Services
  final onboardingService = OnboardingService(
    configRepository: configRepository,
  );

  final permissionsService = PermissionsService(
    permissionRepository: permissionsRepository,
    configRepository: configRepository,
  );

  final audioService = AudioService(
    audioRepository: audioRepository,
  );

  final libraryService = LibraryService(
    artistRepository: artistRepository,
    playlistRepository: playlistRepository,
    albumRepository: albumRepository,
    genreRepository: genreRepository,
    trackRepository: trackRepository,
  );

  final albumService = AlbumService(
    albumRepository: albumRepository,
    trackRepository: trackRepository,
  );

  final playlistService = PlaylistService(
    playlistRepository: playlistRepository,
  );

  // Blocs
  final onboardingBloc = OnboardingBloc(
    onboardingService: onboardingService,
  );

  final permissionsBloc = PermissionsBloc(
    permissionsService: permissionsService,
  );

  final audioBloc = AudioBloc(
    audioService: audioService,
  );

  final libraryBloc = LibraryBloc(
    permissionsService: permissionsService,
    libraryService: libraryService,
  );

  // App
  final app = RetipApp(
    permissionsBloc: permissionsBloc,
    playlistService: playlistService,
    onboardingBloc: onboardingBloc,
    albumService: albumService,
    libraryBloc: libraryBloc,
    audioBloc: audioBloc,
    router: router,
    theme: theme,
  );

  runApp(app);
}
