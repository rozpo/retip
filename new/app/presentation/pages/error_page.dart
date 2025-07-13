import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found'),
            FilledButton(
              onPressed: () {
                context.go(RetipRoutes.home);
              },
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}
