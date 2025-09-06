import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class ThemeModeSegmentedButtonWidget extends StatefulWidget {
  const ThemeModeSegmentedButtonWidget({super.key});

  @override
  State<ThemeModeSegmentedButtonWidget> createState() =>
      _ThemeModeSegmentedButtonWidgetState();
}

class _ThemeModeSegmentedButtonWidgetState
    extends State<ThemeModeSegmentedButtonWidget> {
  var _mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return SegmentedButton<ThemeMode>(
      expandedInsets: EdgeInsets.symmetric(horizontal: 16),
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        setState(() {
          _mode = newSelection.first;
        });
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
      selected: {_mode},
    );
  }
}
