import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/theme/theme_cubit.dart';

class SettingsView extends StatelessWidget {
  final ThemeCubit themeCubit;

  const SettingsView({required this.themeCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsView'),
        actions: [
          if (kReleaseMode == false) ...[
            IconButton(
              onPressed: () {
                context.push('/logger');
              },
              icon: Icon(Icons.troubleshoot),
            ),
            IconButton(
              onPressed: () {
                context.push('/dev');
              },
              icon: Icon(Icons.developer_board),
            ),
          ],
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            bloc: themeCubit,
            builder: (context, state) {
              return DropdownButton<ThemeMode>(
                value: state.themeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  themeCubit.changeThemeMode(value);
                },
              );
            },
          ),

          // SwitchListTile(
          //   value: state.showPerformanceOverlay,
          //   title: Text('showPerformanceOverlay'),
          //   onChanged: (bool value) {
          //     cubit.update(showPerformanceOverlay: value);
          //   },
          // ),
        ],
      ),
    );
  }
}
