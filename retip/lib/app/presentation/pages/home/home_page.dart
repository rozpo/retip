import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: SettingsIconButtonWidget(),
        title: Text(l10n.appName),
      ),
      body: Placeholder(),
    );
  }
}
