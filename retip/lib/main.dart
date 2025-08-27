import 'package:flutter/material.dart';
import 'package:retip/app/data/repositories/onboarding_repository_i.dart';

import 'app/data/providers/shared_preferences_provider.dart';
import 'app/retip_app.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  final router = RetipRouter();
  final theme = RetipTheme();

  final sharedPreferencesProvider = await SharedPreferencesProvider.init();

  final onboardingRepository = OnboardingRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  final app = RetipApp(
    onboardingRepository: onboardingRepository,
    router: router,
    theme: theme,
  );

  runApp(app);
}
