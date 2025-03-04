import 'package:flutter/material.dart';

import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/config_repository_i.dart';
import 'app/data/repositories/permission_repository_i.dart';
import 'app/retip_app.dart';
import 'core/router/retip_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers
  final sharedPreferencesProvider = await SharedPreferencesProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();

  // Repositories
  final configRepository = ConfigRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  final permissionRepository = PermissionRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
  );

  // Core
  final router = RetipRouter();

  final app = RetipApp(
    permissionRepository: permissionRepository,
    configRepository: configRepository,
    router: router,
  );

  runApp(app);
}
