import 'package:flutter/material.dart';
import 'package:retip/app/presentation/library/library_page.dart';
import 'package:retip/app/views/home/pages/home/home_page.dart';
import 'package:retip/app/views/home/pages/search/search_page.dart';
import 'package:retip/app/views/settings/settings_page.dart';

class HomeView extends StatefulWidget {
  final PageController pageController;

  const HomeView({
    required this.pageController,
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
