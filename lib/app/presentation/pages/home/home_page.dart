import 'package:flutter/material.dart';
import 'package:retip/app/presentation/views/home/home_page.dart';
import 'package:retip/app/presentation/views/library/library_page.dart';
import 'package:retip/app/presentation/views/search/search_page.dart';
import 'package:retip/app/presentation/views/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;

  const HomePage({
    required this.pageController,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget.pageController,
        children: [
          SearchPage(isSelected: () => true),
          const RetipPage(),
          const LibraryPage(),
          const SettingsPage(),
        ],
      ),
    );
  }
}
