import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';

class ProfileIconButtonWidget extends StatelessWidget {
  const ProfileIconButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () => context.push(RetipRoutes.profile),
      icon: const Icon(Icons.person_outline),
    );
  }
}
