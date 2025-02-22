import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_route.dart';
import '../../../domain/usecases/config_usecase.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oboarding'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.read<ConfigUsecase>().disableOnboarding();
            context.go(RetipRoute.permission);
          },
          child: const Text('Proceed'),
        ),
      ),
    );
  }
}
