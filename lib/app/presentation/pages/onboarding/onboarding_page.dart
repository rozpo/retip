import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/repositories/config_repository.dart';

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
          onPressed: () async {
            await context.read<ConfigRepository>().setOnboardingStatus(false);

            if (context.mounted) {
              context.go(RetipRoutes.home);
            }
          },
          child: const Text('Get Started'),
        ),
      ),
    );
  }
}
