import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:retip/app/presentation/blocs/permissions/permissions_bloc.dart';
import 'package:retip/app/presentation/blocs/tracks/tracks_bloc.dart';
import 'package:retip/core/router/retip_router.dart';

import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final PermissionsBloc permissionsBloc;
  final OnboardingBloc onboardingBloc;
  final TracksBloc tracksBloc;
  final RetipRouter router;
  final RetipTheme theme;

  const RetipApp({
    required this.permissionsBloc,
    required this.onboardingBloc,
    required this.tracksBloc,
    required this.router,
    required this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => permissionsBloc),
        BlocProvider(create: (context) => onboardingBloc),
        BlocProvider(create: (context) => tracksBloc),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.system,
        darkTheme: theme.dark,
        routerConfig: router,
        theme: theme.light,
      ),
    );
  }
}
