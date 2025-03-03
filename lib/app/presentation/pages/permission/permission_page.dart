import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_router.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Page'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            hasPermission = true;
            context.go(RetipRouter.home);
          },
          child: const Text('ALLOW'),
        ),
      ),
    );
  }
}
