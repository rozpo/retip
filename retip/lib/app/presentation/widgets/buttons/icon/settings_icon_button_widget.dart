import 'package:flutter/material.dart';

import '../../../../../core/router/retip_route.dart';

class SettingsIconButtonWidget extends StatelessWidget {
  const SettingsIconButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () => RetipRoute.settings.push(context),
      icon: Icon(Icons.settings),
    );
  }
}
