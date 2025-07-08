import 'package:flutter/material.dart';
import 'package:retip/new/app/data/providers/objectbox_provider.dart';
import 'package:retip/new/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/new/app/data/repositories/track_repository.dart';
import 'package:retip/new/app/domain/services/library_service.dart';

import 'app/retip_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectboxProvider = await ObjectboxProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();

  final trackRepository = TrackRepository(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final libraryService = LibraryService(
    trackRepository: trackRepository,
  );

  libraryService.scan();

  final app = RetipApp(
    libraryService: libraryService,
  );

  runApp(app);
}
