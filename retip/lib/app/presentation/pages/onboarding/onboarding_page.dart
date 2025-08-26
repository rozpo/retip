import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Onboarding content goes here'),
            ElevatedButton(
              onPressed: () {
                RetipRouter.onboardingDone = true;
                context.go('/permissions');
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
