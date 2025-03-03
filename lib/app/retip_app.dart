import 'package:flutter/material.dart';

import '../core/router/retip_router.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RetipRouter.router,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}
