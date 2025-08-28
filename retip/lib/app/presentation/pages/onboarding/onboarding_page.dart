import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/blocs/onboarding/onboarding_bloc.dart';

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
            BlocListener<OnboardingBloc, OnboardingState>(
              listener: (context, state) {
                if (state is OnboardingCompletedState) {
                  // Navigate to home page
                  context.go('/');
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  final bloc = context.read<OnboardingBloc>();

                  bloc.add(OnboardingCompleteEvent());
                },
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
