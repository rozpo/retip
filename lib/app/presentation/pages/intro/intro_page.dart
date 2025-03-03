import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/intro_usecases.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intro Page'),
      ),
      body: Center(
        child: FilledButton.icon(
          icon: const Icon(Icons.arrow_right),
          label: const Text('Get Started'),
          onPressed: () {
            GetIt.I.get<IntroUsecases>().disableIntroPage();
            context.go('/');
          },
        ),
      ),
    );
  }
}
