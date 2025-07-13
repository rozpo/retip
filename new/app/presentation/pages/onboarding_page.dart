import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';
import '../../../core/router/retip_routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            RetipRouter.isOnboardingFinished = true;
            context.go(RetipRoutes.permissions);
          },
          child: const Text('Get started'),
        ),
      ),
    );
  }
}
