import 'package:flutter/material.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  final RetipTheme theme;

  const RetipApp({required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Placeholder()),
      themeMode: ThemeMode.system,
      darkTheme: theme.dark,
      theme: theme.light,
    );
  }
}
