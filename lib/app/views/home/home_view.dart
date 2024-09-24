import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/repositories/on_audio_query_repository.dart';
import 'package:retip/app/views/home/pages/home/home_page.dart';
import 'package:retip/app/views/home/pages/library/library_page.dart';
import 'package:retip/app/views/home/pages/search/search_page.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/player/player_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import 'bloc/home_bloc.dart';
import 'widgets/retip_icon.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(repository: OnAudioQueryRepository());
        return bloc..add(HomeGetTracksEvent());
      },
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final PageController pageController = PageController();
  int index = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).retip),
        actions: [
          IconButton(
            onPressed: () => bloc.add(HomeSortTracksEvent()),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomePage(),
          SearchPage(),
          LibraryPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: colorScheme.outline,
        fixedColor: colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            activeIcon: RetipIcon(color: colorScheme.primary),
            icon: RetipIcon(color: colorScheme.outline),
            label: RetipL10n.of(context).home,
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.search),
            icon: const Icon(Icons.search_outlined),
            label: RetipL10n.of(context).search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_music),
            label: RetipL10n.of(context).library,
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          index = value;

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );

          setState(() {});
        },
      ),
    );
  }
}
