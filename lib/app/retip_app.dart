import 'package:flutter/material.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: RetipTheme.light,
      darkTheme: RetipTheme.dark,
      highContrastTheme: RetipTheme.contrastLight,
      highContrastDarkTheme: RetipTheme.contrastDark,
      home: const Placeholder(),
    );
  }
}
