import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'domain/repositories/config_repository.dart';
import 'domain/repositories/permission_repository.dart';
import 'domain/repositories/settings_repository.dart';

class RetipApp extends StatelessWidget {
  final PermissionRepository permissionRepository;
  final SettingsRepository settingsRepository;
  final ConfigRepository configRepository;
  final RetipRouter router;
  final RetipTheme theme;

  const RetipApp({
    required this.permissionRepository,
    required this.settingsRepository,
    required this.configRepository,
    required this.router,
    required this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => permissionRepository),
        RepositoryProvider(create: (context) => settingsRepository),
        RepositoryProvider(create: (context) => configRepository),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.system,
        darkTheme: theme.dark(),
        routerConfig: router,
      ),
    );
  }
}
