import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import '../blocs/permissions/permissions_bloc.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionsBloc, PermissionsState>(
      listener: (context, state) {
        if (state is PermissionsGrantedState) {
          context.go(RetipRoutes.home);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Permissions'),
        ),
        body: Center(
          child: FilledButton(
            onPressed: () {
              context
                  .read<PermissionsBloc>()
                  .add(const PermissionsRequestEvent());
            },
            child: const Text('Request permissions'),
          ),
        ),
      ),
    );
  }
}
