import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/library_usecase.dart';
import '../../views/albums_view.dart';
import '../../views/artists_view.dart';
import '../../views/genres_view.dart';
import '../../views/tracks_view.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryUsecase>().call();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
