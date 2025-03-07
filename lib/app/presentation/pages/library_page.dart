import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../cubits/library/library_cubit.dart';
import '../views/albums_view.dart';
import '../views/artists_view.dart';
import '../views/genres_view.dart';
import '../views/playlists_view.dart';
import '../views/tracks_view.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);
    final cubit = context.read<LibraryCubit>();

    if (cubit.state is LibraryInitial) {
      cubit.scanLibrary();
    }

    return BlocListener<LibraryCubit, LibraryState>(
      listener: (context, state) {
        if (state is LibraryScanned && state.count > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ListTile(
                trailing: IconButton(
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    icon: const Icon(Icons.close)),
                title: Text('${l10n.libraryScanned} (${state.count})'),
              ),
            ),
          );
        }
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.library),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: l10n.playlists),
                Tab(text: l10n.artists),
                Tab(text: l10n.albums),
                Tab(text: l10n.genres),
                Tab(text: l10n.tracks),
              ],
            ),
          ),
          body: const TabBarView(
            // TODO: Inherit the physics from the ThemeData
            physics: BouncingScrollPhysics(),
            children: [
              PlaylistsView(),
              ArtistsView(),
              AlbumsView(),
              GenresView(),
              TracksView(),
            ],
          ),
        ),
      ),
    );
  }
}
