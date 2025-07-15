import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'presentation/blocs/audio/audio_bloc.dart';
import 'presentation/blocs/library/library_bloc.dart';
import 'presentation/blocs/onboarding/onboarding_bloc.dart';
import 'presentation/blocs/permissions/permissions_bloc.dart';

class RetipApp extends StatelessWidget {
  final PermissionsBloc permissionsBloc;
  final OnboardingBloc onboardingBloc;
  final LibraryBloc libraryBloc;
  final AudioBloc audioBloc;
  final RetipRouter router;

  const RetipApp({
    required this.permissionsBloc,
    required this.onboardingBloc,
    required this.libraryBloc,
    required this.audioBloc,
    required this.router,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => permissionsBloc),
        BlocProvider(create: (context) => onboardingBloc),
        BlocProvider(create: (context) => libraryBloc),
        BlocProvider(create: (context) => audioBloc),
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
