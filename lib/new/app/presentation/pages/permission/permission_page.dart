import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/router/retip_router.dart';
import '../../cubits/permission/permission_cubit.dart';
import '../../cubits/theme/theme_cubit.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);
    final router = context.read<RetipRouter>();
    final cubit = context.read<PermissionCubit>();

    return BlocConsumer<PermissionCubit, PermissionState>(
      listener: (context, state) {
        if (state.isGranted) {
          context.go(router.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => cubit.requestPermission(),
                      child: Text(l10n.openAppSettings),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        final index = Random().nextInt(Colors.primaries.length);
                        final nextColor = Colors.primaries[index];

                        context.read<ThemeCubit>().primaryColor = nextColor;
                      },
                      child: Text(l10n.allow),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
