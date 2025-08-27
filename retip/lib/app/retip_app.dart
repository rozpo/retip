import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/repositories/onboarding_repository.dart';
import 'package:retip/core/router/retip_router.dart';

import '../core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;
  final RetipTheme theme;

  final OnboardingRepository onboardingRepository;

  const RetipApp({
    required this.router,
    required this.theme,
    required this.onboardingRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => onboardingRepository),
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
