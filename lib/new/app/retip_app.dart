import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/usecases/scan_library_usecase.dart';
import 'domain/usecases/tracks_stream_usecase.dart';
import 'presentation/pages/library_page.dart';

class RetipApp extends StatelessWidget {
  final TracksStreamUsecase tracksStreamUsecase;
  final ScanLibraryUsecase scanLibraryUsecase;

  const RetipApp({
    required this.tracksStreamUsecase,
    required this.scanLibraryUsecase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => tracksStreamUsecase),
        RepositoryProvider(create: (_) => scanLibraryUsecase),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        home: const LibraryPage(),
        theme: ThemeData.light(),
      ),
    );
  }
}
