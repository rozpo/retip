import 'package:flutter/material.dart';

import '../../../../core/router/retip_route.dart';
import '../../../../core/router/retip_router.dart';

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
            RetipRoute.home.go(context);
          },
          child: Text('Grant permissions'),
        ),
      ),
    );
  }
}
