import 'package:flutter/material.dart';

import 'app/data/providers/app_settings_provider.dart';
import 'app/data/providers/just_audio_provider.dart';
import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/album_repository_i.dart';
import 'app/data/repositories/artist_repository_i.dart';
import 'app/data/repositories/audio_repository_i.dart';
import 'app/data/repositories/config_repository_i.dart';
import 'app/data/repositories/library_repository_i.dart';
import 'app/data/repositories/permission_repository_i.dart';
import 'app/data/repositories/settings_repository_i.dart';
import 'app/data/repositories/track_repository_i.dart';
import 'app/presentation/blocs/album/album_bloc.dart';
import 'app/presentation/blocs/artist/artist_bloc.dart';
import 'app/presentation/blocs/audio/audio_bloc.dart';
import 'app/presentation/blocs/track/track_bloc.dart';
import 'app/presentation/cubits/library/library_cubit.dart';
import 'app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'app/presentation/cubits/permission/permission_cubit.dart';
import 'app/retip_app.dart';
import 'core/l10n/retip_l10n.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers
  final sharedPreferencesProvider = await SharedPreferencesProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();
  final appSettingsProvider = await AppSettingsProvider.init();
  final justAudioProvider = await JustAudioProvider.init();
  final objectboxProvider = await ObjectboxProvider.init();

  // Repositories
  final configRepository = ConfigRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  final permissionRepository = PermissionRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
  );

  final settingsRepository = SettingsRepositoryI(
    appSettingsProvider: appSettingsProvider,
  );

  final libraryRepository = LibraryRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final trackRepository = TrackRepositoryI(
    objectboxProvider: objectboxProvider,
  );

  final audioRepository = AudioRepositoryI(
    justAudioProvider: justAudioProvider,
  );

  final albumRepository = AlbumRepositoryI(
    objectboxProvider: objectboxProvider,
  );

  final artistRepository = ArtistRepositoryI(
    objectboxProvider: objectboxProvider,
  );

  // Cubits
  final onboardingCubit = OnboardingCubit(
    configRepository: configRepository,
  );

  final permissionCubit = PermissionCubit(
    permissionRepository: permissionRepository,
    settingsRepository: settingsRepository,
  );

  final libraryCubit = LibraryCubit(
    libraryRepository: libraryRepository,
  );

  // Blocs
  final audioBloc = AudioBloc(
    audioRepository: audioRepository,
    trackRepository: trackRepository,
  );

  final albumBloc = AlbumBloc(
    albumRepository: albumRepository,
  );

  final trackBloc = TrackBloc(
    audioRepository: audioRepository,
    trackRepository: trackRepository,
  );

  final artistBloc = ArtistBloc(
    artistRepository: artistRepository,
  );

  // Core
  final router = RetipRouter();
  final theme = RetipTheme();
  final l10n = RetipL10n();

  final app = RetipApp(
    permissionRepository: permissionRepository,
    settingsRepository: settingsRepository,
    configRepository: configRepository,
    onboardingCubit: onboardingCubit,
    permissionCubit: permissionCubit,
    libraryCubit: libraryCubit,
    artistBloc: artistBloc,
    audioBloc: audioBloc,
    trackBloc: trackBloc,
    albumBloc: albumBloc,
    router: router,
    theme: theme,
    l10n: l10n,
  );

  runApp(app);
}
