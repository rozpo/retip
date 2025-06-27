import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/dev/dev_cubit.dart';
import '../../cubits/theme/theme_cubit.dart';

class SettingsView extends StatelessWidget {
  final ThemeCubit themeCubit;

  const SettingsView({required this.themeCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<DevCubit, DevState>(
          bloc: context.read(),
          builder: (context, state) {
            return GestureDetector(
              onTap: () => context.read<DevCubit>().stepToDevMode(),
              child: Text('SettingsView'),
            );
          },
        ),
        actions: [
          BlocBuilder<DevCubit, DevState>(
            bloc: context.read(),
            builder: (context, state) {
              if (state is! DevEnabled) return SizedBox();

              return IconButton(
                onPressed: () {
                  context.push('/logger');
                },
                icon: Icon(Icons.troubleshoot),
              );
            },
          ),
          BlocBuilder<DevCubit, DevState>(
            bloc: context.read(),
            builder: (context, state) {
              if (state is! DevEnabled) return SizedBox();

              return IconButton(
                onPressed: () {
                  context.push('/dev');
                },
                icon: Icon(Icons.developer_board),
              );
            },
          ),
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
        ],
      ),
    );
  }
}
