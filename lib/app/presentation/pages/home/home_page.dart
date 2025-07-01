import 'package:flutter/material.dart';
import 'package:retip/app/presentation/views/home/home_view.dart';
import 'package:retip/app/presentation/views/library/library_view.dart';
import 'package:retip/app/presentation/views/search/search_view.dart';

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
          SearchView(isSelected: () => true),
          const HomeView(),
          const LibraryView(),
        ],
      ),
    );
  }
}
