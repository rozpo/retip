import 'package:flutter/material.dart';

import '../widgets/sheets/track_sheet_widget.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {


        
        return ListTile(
          title: Text('Track $index'),
          leading: const Icon(Icons.music_note),
          trailing: IconButton(
            onPressed: () => const TrackSheetWidget().show(context),
            icon: const Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}
