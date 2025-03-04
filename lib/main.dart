import 'package:flutter/material.dart';

import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/config_repository_i.dart';
import 'app/retip_app.dart';
import 'core/router/retip_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers
  final sharedPreferencesProvider = await SharedPreferencesProvider.init();

  // Repositories
  final configRepository = ConfigRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  // Core
  final router = RetipRouter();

  final app = RetipApp(
    configRepository: configRepository,
    router: router,
  );

  runApp(app);
}
