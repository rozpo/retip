import 'package:flutter/material.dart';

import '../core/router/retip_router.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter _retipRouter;

  const RetipApp({
    required RetipRouter retipRouter,
    super.key,
  }) : _retipRouter = retipRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _retipRouter,
    );
  }
}
