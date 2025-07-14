import 'package:flutter/material.dart';

import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/repositories/track_repository.dart';
import 'app/domain/services/library_service.dart';
import 'app/presentation/blocs/library/library_bloc.dart';
import 'app/retip_app.dart';
import 'core/router/retip_router.dart';

void main() async {
  final router = RetipRouter();

  final objectboxProvider = await ObjectboxProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();

  final trackRepository = TrackRepository(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  final libraryService = LibraryService(trackRepository: trackRepository);

  final libraryBloc = LibraryBloc(libraryService: libraryService);

  final app = RetipApp(
    libraryBloc: libraryBloc,
    router: router,
  );

  runApp(app);
}
