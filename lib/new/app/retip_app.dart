import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/usecases/library_usecase.dart';
import 'domain/usecases/track_usecase.dart';
import 'presentation/pages/library_page.dart';

class RetipApp extends StatelessWidget {
  final LibraryUsecase libraryUsecase;
  final TrackUsecase trackUsecase;

  const RetipApp({
    required this.libraryUsecase,
    required this.trackUsecase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => libraryUsecase),
        RepositoryProvider(create: (_) => trackUsecase),
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
