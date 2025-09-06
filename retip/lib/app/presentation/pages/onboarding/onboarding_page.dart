import 'package:flutter/material.dart';

import '../../../../core/router/retip_route.dart';
import '../../../../core/router/retip_router.dart';

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
            RetipRoute.home.go(context);
          },
          child: Text('Get started'),
        ),
      ),
    );
  }
}
