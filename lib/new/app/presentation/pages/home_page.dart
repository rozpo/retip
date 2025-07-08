import 'package:flutter/material.dart';

import '../../domain/services/library_service.dart';

class HomePage extends StatelessWidget {
  final LibraryService _libraryService;

  const HomePage({
    required LibraryService libraryService,
    super.key,
  }) : _libraryService = libraryService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _libraryService.tracksStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = snapshot.requireData;

        return Scaffold(
          appBar: AppBar(
            title: Text('Library ${data.length}'),
          ),
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final track = data[index];

              return ListTile(
                title: Text(track.title),
                subtitle: Text(track.artist),
              );
            },
          ),
        );
      },
    );
  }
}
