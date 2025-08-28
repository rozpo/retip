import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/permissions/permissions_bloc.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionsBloc, PermissionsState>(
      listener: (context, state) {
        if (state is PermissionsGrantedState) {
          context.go('/');
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Permissions content goes here'),
              FilledButton(
                onPressed: () {
                  final bloc = context.read<PermissionsBloc>();
                  bloc.add(PermissionsRequestEvent());
                },
                child: const Text('Request Permission'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
