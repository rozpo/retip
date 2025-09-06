import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/dev/dev_cubit.dart';

class DevPage extends StatelessWidget {
  final DevCubit devCubit;

  const DevPage({required this.devCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevCubit, DevState>(
      bloc: devCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Developer'),
            actions: [
              Switch(
                value: state.isEnabled,
                onChanged: (value) {
                  value ? devCubit.enable() : devCubit.disable();
                },
              ),
            ],
          ),
          body: ListView(children: [
          ],
        ),
        );
      },
    );
  }
}
