import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/app/presentation/widgets/buttons/icon/settings_icon_button_widget.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: SettingsIconButtonWidget(),
            title: Text('Library'),
          ),
          BlocBuilder<TrackBloc, TrackState>(
            builder: (context, state) {
              final tracks = <TrackEntity>[];

              if (state is TrackIdleState) {
                tracks.addAll(state.tracks);
              }

              return SliverList.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];

                  return ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text(track.title),
                    subtitle: Text(track.artist),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
