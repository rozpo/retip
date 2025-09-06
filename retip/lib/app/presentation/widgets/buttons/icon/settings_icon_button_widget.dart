import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/avatars/avatar_plus_widget.dart';

import '../../../../../core/router/retip_route.dart';

class SettingsIconButtonWidget extends StatelessWidget {
  const SettingsIconButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => RetipRoute.profile.push(context),
      icon: AvatarPlusWidget(),
    );
  }
}
