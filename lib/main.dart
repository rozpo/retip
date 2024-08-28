import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/audio/retip_audio.dart';

void main() async {
  // Initialize
  await init();

  // Setup the dependency injection
  setup();

  // Run application
  runApp(const RetipApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'dev.rozpo.retip.audio',
    androidNotificationIcon: 'drawable/ic_stat_name',
    androidStopForegroundOnPause: true,
    androidNotificationOngoing: true,
  );
}

void setup({RetipAudio? audio}) {
  GetIt.I.registerSingleton<RetipAudio>(audio ?? RetipAudio());
}
