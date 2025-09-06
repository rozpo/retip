import 'package:flutter/material.dart';

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
    return SegmentedButton<ThemeMode>(
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        setState(() {
          _mode = newSelection.first;
        });
      },
      segments: [
        ButtonSegment<ThemeMode>(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_4),
          label: Text('System'),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode),
          label: Text('Light'),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode),
          label: Text('Dark'),
        ),
      ],
      selected: {_mode},
    );
  }
}
