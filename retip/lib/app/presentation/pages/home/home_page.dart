import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [SettingsIconButtonWidget()],
      ),
      body: Placeholder(),
    );
  }
}
