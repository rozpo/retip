import 'package:flutter/material.dart';
import 'package:retip/new/app/domain/services/library_service.dart';

import 'presentation/pages/home_page.dart';

class RetipApp extends StatelessWidget {
  final LibraryService libraryService;

  const RetipApp({required this.libraryService, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(
        libraryService: libraryService,
      ),
    );
  }
}
