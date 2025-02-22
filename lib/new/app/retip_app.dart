import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'domain/usecases/album_usecase.dart';
import 'domain/usecases/artist_usecase.dart';
import 'domain/usecases/genre_usecase.dart';
import 'domain/usecases/library_usecase.dart';
import 'domain/usecases/permission_usecase.dart';
import 'domain/usecases/track_usecase.dart';
import 'presentation/pages/permission/bloc/permission_bloc.dart';

class RetipApp extends StatelessWidget {
  final PermissionUsecase permissionUsecase;
  final LibraryUsecase libraryUsecase;
  final ArtistUsecase artistUsecase;
  final AlbumUsecase albumUsecase;
  final GenreUsecase genreUsecase;
  final TrackUsecase trackUsecase;

  final PermissionBloc permissionBloc;

  const RetipApp({
    required this.permissionUsecase,
    required this.libraryUsecase,
    required this.permissionBloc,
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
        RepositoryProvider(create: (_) => permissionUsecase),
        RepositoryProvider(create: (_) => libraryUsecase),
        RepositoryProvider(create: (_) => artistUsecase),
        RepositoryProvider(create: (_) => albumUsecase),
        RepositoryProvider(create: (_) => genreUsecase),
        RepositoryProvider(create: (_) => trackUsecase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => permissionBloc),
        ],
        child: MaterialApp.router(
          routerConfig: RetipRouter(),
          themeMode: ThemeMode.system,
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
        ),
      ),
    );
  }
}
