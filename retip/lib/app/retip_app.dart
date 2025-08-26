import 'package:flutter/material.dart';
import 'package:retip/core/router/retip_router.dart';

class RetipApp extends StatelessWidget {
  final RetipRouter router;

  const RetipApp({required this.router, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
