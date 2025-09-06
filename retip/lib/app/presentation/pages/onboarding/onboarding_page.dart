import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/onboarding/onboarding_cubit.dart';

import '../../../../core/router/retip_route.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.read<OnboardingCubit>().finish();
            RetipRoute.home.go(context);
          },
          child: Text('Get started'),
        ),
      ),
    );
  }
}
