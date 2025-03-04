import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/retip_router.dart';
import 'domain/facades/intro_facade.dart';

class RetipApp extends StatelessWidget {
  final IntroFacade onboardingFacade;

  const RetipApp({
    required this.onboardingFacade,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => onboardingFacade),
      ],
      child: MaterialApp.router(
        routerConfig: RetipRouter.router,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
