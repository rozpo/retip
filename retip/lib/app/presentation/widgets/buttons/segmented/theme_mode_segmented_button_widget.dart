import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/theme/theme_cubit.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class ThemeModeSegmentedButtonWidget extends StatelessWidget {
  const ThemeModeSegmentedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SegmentedButton<ThemeMode>(
          expandedInsets: EdgeInsets.symmetric(horizontal: 16),
          onSelectionChanged: (Set<ThemeMode> newSelection) {
            context.read<ThemeCubit>().setThemeMode(newSelection.first);
          },
          segments: [
            ButtonSegment<ThemeMode>(
              value: ThemeMode.system,
              icon: Icon(Icons.brightness_4),
              label: Text(l10n.system),
            ),
            ButtonSegment<ThemeMode>(
              value: ThemeMode.light,
              icon: Icon(Icons.light_mode),
              label: Text(l10n.light),
            ),
            ButtonSegment<ThemeMode>(
              value: ThemeMode.dark,
              icon: Icon(Icons.dark_mode),
              label: Text(l10n.dark),
            ),
          ],
          selected: {state.themeMode},
        );
      },
    );
  }
}
