import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'presentation/blocs/library/library_bloc.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;
  final LibraryBloc libraryBloc;

  const RetipApp({
    required this.router,
    required this.libraryBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => libraryBloc),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        routerConfig: router,
      ),
    );
  }
}
