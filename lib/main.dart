import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/data/repositories/audio_repository_implementation.dart';
import 'package:retip/app/data/repositories/library_repository_implementation.dart';
import 'package:retip/app/data/repositories/theme_repository_implementation.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/app/services/repositories/audio_repository.dart';
import 'package:retip/app/services/repositories/library_repository.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Initialize
  await init();

  // Setup the dependency injection
  await setup();

  // Run application
  runApp(RetipApp(
    themeRepository: ThemeRepositoryImplementation(
      provider: SharedPreferencesProvider(),
    ),
  ));
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  const icon = kReleaseMode ? 'mipmap/ic_launcher' : 'drawable/ic_stat_name';

  await JustAudioBackground.init(
    androidNotificationChannelId: 'dev.rozpo.retip.audio',
    androidNotificationIcon: icon,
    androidStopForegroundOnPause: true,
    androidNotificationOngoing: true,
  );
}

Future<void> setup() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(sharedPrefs);

  final packageInfo = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(packageInfo);

  final player = GetIt.I.registerSingleton<RetipAudio>(RetipAudio());

  final sharedPrefsProvider = SharedPreferencesProvider();

  // Library repository register
  GetIt.I.registerSingleton<LibraryRepository>(
    LibraryRepositoryImplementation(
      onAudioQueryProvider: OnAudioQueryProvider(),
      sharedPreferencesProvider: sharedPrefsProvider,
    ),
  );

  final audio = GetIt.I.registerSingleton<AudioRepository>(
    AudioRepositoryImplementation(
      sharedPreferencesProvider: sharedPrefsProvider,
    ),
  );

  await player.setShuffleMode(audio.getShuffleMode());
  await player.setRepeatMode(audio.getRepeatMode());
}
