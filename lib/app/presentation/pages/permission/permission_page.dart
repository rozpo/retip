import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/repositories/permission_repository.dart';

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
          onPressed: () async {
            final permissionRepository = context.read<PermissionRepository>();
            final result = await permissionRepository.requestMediaPermission();

            if (context.mounted && result == true) {
              context.go(RetipRoutes.home);
            }
          },
          child: const Text('Allow Permission'),
        ),
      ),
    );
  }
}
