import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/settings_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.read<SettingsRepository>().openAppSettings();
          },
          child: const Text('Open App Settings'),
        ),
      ),
    );
  }
}
