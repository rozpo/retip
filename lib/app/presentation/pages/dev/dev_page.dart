import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/dev/dev_cubit.dart';
import 'views/dev_disabled_view.dart';
import 'views/dev_enabled_view.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevCubit, DevState>(
      builder: (context, state) {
        return switch (state) {
          DevEnabled() => DevEnabledView(),
          DevDisabled() => DevDisabledView(),
        };
      },
    );
  }
}
