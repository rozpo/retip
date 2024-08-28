import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/audio/retip_audio.dart';

void main() {
  // Initialize
  WidgetsFlutterBinding.ensureInitialized();

  // Setup the dependency injection
  setup();

  // Run application
  runApp(const RetipApp());
}

void setup({RetipAudio? audio}) {
  GetIt.I.registerSingleton<RetipAudio>(audio ?? RetipAudio());
}
