import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/albums_view.dart';
import '../../views/artists_view.dart';
import '../../views/genres_view.dart';
import '../../views/tracks_view.dart';
import 'bloc/library_bloc.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: PageView(
              children: const [
                TracksView(),
                AlbumsView(),
                ArtistsView(),
                GenresView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
