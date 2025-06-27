import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/run_mode.dart';
import '../../../cubits/dev/dev_cubit.dart';

class DevEnabledView extends StatelessWidget {
  const DevEnabledView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevCubit, DevState>(
      bloc: context.read(),
      builder: (context, state) {
        if (state is! DevEnabled) return SizedBox();

        final cubit = context.read<DevCubit>();
        return Scaffold(
          appBar: AppBar(title: Text('Developer')),
          body: ListView(
            children: [
              if (RunMode.isDebug) ...[
                SwitchListTile(
                  value: state.debugRepaintRainbowEnabled,
                  title: Text('debugRepaintRainbowEnabled'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugRepaintRainbowEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugPaintLayerBordersEnabled,
                  title: Text('debugPaintLayerBordersEnabled'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugPaintLayerBordersEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugShowCheckedModeBanner,
                  title: Text('debugShowCheckedModeBanner'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugShowCheckedModeBanner: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugPaintPointersEnabled,
                  title: Text('debugPaintPointersEnabled'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugPaintPointersEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugPaintSizeEnabled,
                  title: Text('debugPaintSizeEnabled'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugPaintSizeEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugPaintBaselinesEnabled,
                  title: Text('debugPaintBaselinesEnabled'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugPaintBaselinesEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugRepaintTextRainbowEnabled,
                  title: Text('debugRepaintTextRainbowEnabled'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugRepaintTextRainbowEnabled: value);
                  },
                ),
                SwitchListTile(
                  value: state.debugInvertedOversizedImages,
                  title: Text('debugInvertOversizedImages'),
                  onChanged: (bool value) {
                    cubit.setFlag(debugInvertedOversizedImages: value);
                  },
                ),
              ],
              SwitchListTile(
                value: state.showPerformanceOverlay,
                title: Text('showPerformanceOverlay'),
                onChanged: (bool value) {
                  cubit.setFlag(showPerformanceOverlay: value);
                },
              ),
              OutlinedButton(
                onPressed: () async {
                  final result = await showDialog<bool?>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Disable developer mode'),
                        content: Text(
                          'Are you sure you wanna disable developer mode?',
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              context.pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () {
                              context.pop(true);
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );

                  if (result == true) {
                    cubit.disableDevMode();
                  }
                },
                child: Text('Disable developer mode'.toUpperCase()),
              ),
            ],
          ),
        );
      },
    );
  }
}
