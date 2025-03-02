import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/retip_l10n.dart';
import '../../views/albums_view.dart';
import '../../views/artists_view.dart';
import '../../views/genres_view.dart';
import '../../views/tracks_view.dart';
import 'bloc/library_bloc.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return SafeArea(
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                actions: const [
                  IconButton(icon: Icon(Icons.sort), onPressed: null),
                  SizedBox(width: 8),
                  IconButton(icon: Icon(Icons.grid_view), onPressed: null),
                  SizedBox(width: 8),
                ],
                leading: const Icon(Icons.library_music),
                title: Text(l10n.library),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: l10n.tracks),
                    Tab(text: l10n.albums),
                    Tab(text: l10n.artists),
                    Tab(text: l10n.genres),
                  ],
                ),
              ),
              body: const TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  TracksView(),
                  AlbumsView(),
                  ArtistsView(),
                  GenresView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
