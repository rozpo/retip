import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/run_mode.dart';
import '../../cubits/dev/dev_cubit.dart';

class DevView extends StatelessWidget {
  final DevCubit cubit;

  const DevView({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevCubit, DevState>(
      bloc: cubit,

      builder: (context, state) {
        if (state is! DevEnabled) throw Exception();

        return Scaffold(
          appBar: AppBar(title: Text('DevView')),
          body: ListView(
            children: [
              if (RunMode.isDebug) ...[
                SwitchListTile(
                  value: state.debugShowCheckedModeBanner,
                  title: Text('debugShowCheckedModeBanner'),
                  onChanged: (bool value) {
                    cubit.update(debugShowCheckedModeBanner: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugRepaintRainbowEnabled,
                  title: Text('debugRepaintRainbowEnabled'),
                  onChanged: (bool value) {
                    cubit.update(debugRepaintRainbowEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugInvertedOversizedImages,
                  title: Text('debugInvertOversizedImages'),
                  onChanged: (bool value) {
                    cubit.update(debugInvertedOversizedImages: value);
                  },
                ),
              ],
              SwitchListTile(
                value: state.showPerformanceOverlay,
                title: Text('showPerformanceOverlay'),
                onChanged: (bool value) {
                  cubit.update(showPerformanceOverlay: value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
