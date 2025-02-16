import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'app/data/providers/just_audio_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/audio_repository_implementation.dart';
import 'app/data/repositories/debug_repository_implementation.dart';
import 'app/data/repositories/library_repository_implementation.dart';
import 'app/data/repositories/permission_repository_implementation.dart';
import 'app/data/repositories/theme_repository_implementation.dart';
import 'app/domain/repositories/audio_repository.dart';
import 'app/domain/repositories/library_repository.dart';
import 'app/retip_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure that the widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Set the orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Initialize the background audio player
  await JustAudioBackground.init(
    androidNotificationChannelId: 'dev.rozpo.retip.audio',
    androidNotificationIcon: 'drawable/ic_stat_name',
    androidStopForegroundOnPause: true,
    androidNotificationOngoing: true,
  );
  // Setup shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(sharedPrefs);
  // Setup package info
  final packageInfo = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(packageInfo);

  // Register providers
  final onAudioQueryProvider = OnAudioQueryProvider();
  final justAudioProvider = GetIt.I.registerSingleton<JustAudioProvider>(
    JustAudioProvider(),
  );
  final sharedPreferencesProvider = GetIt.I.registerSingleton(
    SharedPreferencesProvider(sharedPreferences: sharedPrefs),
  );

  // Register repositories
  final libraryRepository = GetIt.I.registerSingleton<LibraryRepository>(
    LibraryRepositoryImplementation(
      onAudioQueryProvider: onAudioQueryProvider,
      sharedPreferencesProvider: sharedPreferencesProvider,
    ),
  );
  final audioRepository = GetIt.I.registerSingleton<AudioRepository>(
    AudioRepositoryImplementation(
      sharedPreferencesProvider: sharedPreferencesProvider,
      onAudioQueryProvider: onAudioQueryProvider,
      libraryRepository: libraryRepository,
      justAudioProvider: justAudioProvider,
    ),
  );
  // Initialize the audio repository
  await audioRepository.init();
  // Run application
  runApp(
    RetipApp(
      debugRepository: DebugRepositoryImplementation(
        sharedPreferencesProvider: sharedPreferencesProvider,
      ),
      libraryRepository: libraryRepository,
      permissionRepository: PermissionRepositoryImplementation(
        onAudioQueryProvider: onAudioQueryProvider,
      ),
      audioRepository: audioRepository,
      themeRepository: ThemeRepositoryImplementation(
        provider: sharedPreferencesProvider,
      ),
    ),
  );
}
