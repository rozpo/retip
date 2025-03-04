import 'package:flutter/material.dart';

import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/config_repository_i.dart';
import 'app/domain/facades/intro_facade.dart';
import 'app/retip_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers
  final sharedPreferencesProvider = await SharedPreferencesProvider.init();

  // Repositories
  final configRepository = ConfigRepositoryI(sharedPreferencesProvider);

  // Facades
  final onboardingFacade = IntroFacade(configRepository);

  // App
  final app = RetipApp(
    onboardingFacade: onboardingFacade,
  );

  runApp(app);
}
