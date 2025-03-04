import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'domain/repositories/config_repository.dart';

class RetipApp extends StatelessWidget {
  final ConfigRepository configRepository;

  const RetipApp({
    required this.configRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => configRepository),
      ],
      child: MaterialApp.router(
        routerConfig: RetipRouter.router,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
