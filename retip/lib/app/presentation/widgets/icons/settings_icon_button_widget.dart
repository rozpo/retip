import 'package:flutter/material.dart';
import 'package:retip/core/router/retip_route.dart';

class SettingsIconButtonWidget extends StatelessWidget {
  const SettingsIconButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () => RetipRoute.push(context, RetipRoute.settings),
      icon: Icon(Icons.settings),
    );
  }
}
