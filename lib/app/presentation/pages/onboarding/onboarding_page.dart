import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding Page'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            showOnboarding = false;
            context.go(RetipRouter.home);
          },
          child: const Text('OK'),
        ),
      ),
    );
  }
}
