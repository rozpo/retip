import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_route.dart';
import 'bloc/permission_bloc.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PermissionBloc>();

    return BlocConsumer<PermissionBloc, PermissionState>(
      listener: (context, state) {
        if (state is PermissionGranted) {
          context.go(RetipRoute.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Permission'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    bloc.add(const OpenAppSettingsEvent());
                  },
                  child: const Text('Settings'),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () {
                    bloc.add(const AskForPermissionEvent());
                  },
                  child: const Text('Allow'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
