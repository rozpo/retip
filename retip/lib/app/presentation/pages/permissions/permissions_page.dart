import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/retip_route.dart';
import '../../cubits/permissions/permissions_cubit.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionsCubit, PermissionsState>(
      listener: (context, state) {
        if (state.isGranted) {
          RetipRoute.home.go(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Permissions')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.read<PermissionsCubit>().ask(),
            child: Text('Grant permissions'),
          ),
        ),
      ),
    );
  }
}
