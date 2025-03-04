import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'domain/repositories/config_repository.dart';
import 'domain/repositories/permission_repository.dart';

class RetipApp extends StatelessWidget {
  final PermissionRepository permissionRepository;
  final ConfigRepository configRepository;
  final RetipRouter router;

  const RetipApp({
    required this.permissionRepository,
    required this.configRepository,
    required this.router,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => permissionRepository),
        RepositoryProvider(create: (context) => configRepository),
      ],
      child: MaterialApp.router(
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        routerConfig: router,
      ),
    );
  }
}
