import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../views/explore/explore_view.dart';
import '../../views/home/home_view.dart';
import '../../views/library/library_view.dart';
import '../../views/search/search_view.dart';
import '../../views/settings/settings_page.dart';

import 'cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: state.controller,
            children: const [
              HomeView(),
              ExploreView(),
              SearchView(),
              LibraryView(),
              SettingsPage(),
            ],
          ),
        );
      },
    );
  }
}
