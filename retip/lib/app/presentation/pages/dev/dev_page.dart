import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/onboarding/onboarding_bloc.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Page')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Reset Onboarding'),
            onTap: () {
              final bloc = context.read<OnboardingBloc>();
              bloc.add(OnboardingResetEvent());
            },
          ),
        ],
      ),
    );
  }
}
