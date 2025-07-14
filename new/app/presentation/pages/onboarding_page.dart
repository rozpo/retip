import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import '../blocs/onboarding/onboarding_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingFinishedState) {
          context.go(RetipRoutes.permissions);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Onboarding'),
        ),
        body: Center(
          child: FilledButton(
            onPressed: () {
              context.read<OnboardingBloc>().add(const OnboadringFinishEvent());
            },
            child: const Text('Get started'),
          ),
        ),
      ),
    );
  }
}
