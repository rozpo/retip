import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [ThemeModeSegmentedButtonWidget()],
      ),
    );
  }
}
