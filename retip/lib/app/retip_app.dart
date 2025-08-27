import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:retip/core/router/retip_router.dart';

import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;
  final RetipTheme theme;

  final OnboardingBloc onboardingBloc;

  const RetipApp({
    required this.router,
    required this.theme,
    required this.onboardingBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => onboardingBloc)],
      child: MaterialApp.router(
        themeMode: ThemeMode.system,
        darkTheme: theme.dark,
        routerConfig: router,
        theme: theme.light,
      ),
    );
  }
}
