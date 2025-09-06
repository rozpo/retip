import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import '../../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(children: [ThemeModeSegmentedButtonWidget()]),
    );
  }
}
