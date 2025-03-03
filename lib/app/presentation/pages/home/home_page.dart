import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/usecases/intro_usecases.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: FilledButton.icon(
          icon: const Icon(Icons.arrow_right),
          label: const Text('disable'),
          onPressed: () {
            GetIt.I.get<IntroUsecases>().enableIntroPage();
          },
        ),
      ),
    );
  }
}
