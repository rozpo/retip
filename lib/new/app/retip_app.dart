import 'package:flutter/material.dart';

import 'presentation/pages/library_page.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: const LibraryPage(),
      theme: ThemeData.light(),
    );
  }
}
