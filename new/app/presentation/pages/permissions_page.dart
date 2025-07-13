import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';
import '../../../core/router/retip_routes.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            RetipRouter.isPermissionsGranted = true;
            context.go(RetipRoutes.home);
          },
          child: const Text('Grant permissions'),
        ),
      ),
    );
  }
}
