import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/usecases/album_usecase.dart';
import 'domain/usecases/artist_usecase.dart';
import 'domain/usecases/genre_usecase.dart';
import 'domain/usecases/library_usecase.dart';
import 'domain/usecases/track_usecase.dart';
import 'presentation/pages/library_page.dart';

class RetipApp extends StatelessWidget {
  final LibraryUsecase libraryUsecase;
  final ArtistUsecase artistUsecase;
  final AlbumUsecase albumUsecase;
  final GenreUsecase genreUsecase;
  final TrackUsecase trackUsecase;

  const RetipApp({
    required this.libraryUsecase,
    required this.artistUsecase,
    required this.albumUsecase,
    required this.genreUsecase,
    required this.trackUsecase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => libraryUsecase),
        RepositoryProvider(create: (_) => artistUsecase),
        RepositoryProvider(create: (_) => albumUsecase),
        RepositoryProvider(create: (_) => genreUsecase),
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
