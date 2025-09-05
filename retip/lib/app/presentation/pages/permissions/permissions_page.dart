import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/router/retip_route.dart';
import 'package:retip/core/router/retip_router.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Permissions')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            RetipRouter.isPermissionsGranted = true;
            context.go(RetipRoute.home);
          },
          child: Text('Grant permissions'),
        ),
      ),
    );
  }
}
