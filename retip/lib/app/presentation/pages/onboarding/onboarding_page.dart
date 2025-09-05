import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/router/retip_route.dart';
import 'package:retip/core/router/retip_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            RetipRouter.isOnboardingDone = true;
            context.go(RetipRoute.home);
          },
          child: Text('Get started'),
        ),
      ),
    );
  }
}
