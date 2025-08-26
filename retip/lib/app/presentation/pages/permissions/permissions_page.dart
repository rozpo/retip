import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/router/retip_router.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Permissions content goes here'),
            FilledButton(
              onPressed: () {
                RetipRouter.permissionsGranted = true;
                context.go('/');
              },
              child: const Text('Request Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
