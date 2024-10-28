import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/data/repositories/library_repository_implementation.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/app/services/repositories/library_repository.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Initialize
  await init();

  // Setup the dependency injection
  await setup();

  // Run application
  runApp(const RetipApp());
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

Future<void> setup({RetipAudio? audio}) async {
  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<RetipAudio>(audio ?? RetipAudio());

  // Library repository register
  GetIt.I.registerSingleton<LibraryRepository>(
    LibraryRepositoryImplementation(
      onAudioQueryProvider: OnAudioQueryProvider(),
      sharedPreferencesProvider: SharedPreferencesProvider(),
    ),
  );
}
