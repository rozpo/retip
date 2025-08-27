import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/onboarding_repository.dart';

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
                final onboardingRepository =
                    context.read<OnboardingRepository>();

                onboardingRepository.completeOnboarding();
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
