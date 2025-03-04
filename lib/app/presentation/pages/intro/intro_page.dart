import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/config_repository.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding Page'),
      ),
      body: Center(
        child: FilledButton.icon(
          icon: const Icon(Icons.arrow_right),
          label: const Text('Get Started'),
          onPressed: () {
            context.read<ConfigRepository>().setOnboardingValue(false);
            context.go('/');
          },
        ),
      ),
    );
  }
}
