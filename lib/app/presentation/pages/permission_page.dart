import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../../../core/router/retip_routes.dart';
import '../cubits/permission/permission_cubit.dart';
import '../widgets/info_page_widget.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PermissionCubit>();
    final l10n = context.read<RetipL10n>().of(context);

    return BlocListener<PermissionCubit, PermissionState>(
      listener: (context, state) {
        if (state is PermissionGranted) {
          context.go(RetipRoutes.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InfoPageWidget(
                    description: l10n.storageAccessIsRequired,
                    iconData: Icons.library_music,
                    title: l10n.mediaPermission,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => cubit.openAppSettings(),
                          child: Text(l10n.openAppSettings),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => cubit.requestMediaPermission(),
                          child: Text(l10n.allowAccess),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
