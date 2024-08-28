import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/repositories/on_audio_query_repository.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/track_repository.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<TrackEntity>> future;

  late final TrackRepository repository;
  late final GetAllTracks getAllTracks;

  @override
  void initState() {
    repository = OnAudioQueryRepository();
    getAllTracks = GetAllTracks(repository);

    future = getAllTracks.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).retip),
      ),
      body: FutureBuilder<List<TrackEntity>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData == false) {
            return const Center(
              child: Text('No data'),
            );
          }

          final data = snapshot.requireData;

          final urls = data.map((e) => e.uri).toList();

          final audio = GetIt.instance.get<RetipAudio>();

          audio.playlistAddAll(urls);

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final track = data[index];

              return ListTile(
                onTap: () {
                  audio.stop();
                  audio.seekToIndex(index);
                  audio.play();
                },
                leading: CircleAvatar(
                  child: Text(track.title[0]),
                ),
                title: Text(track.title),
                subtitle: Text(track.artist),
                trailing: const Icon(Icons.more_vert),
              );
            },
          );
        },
      ),
    );
  }
}
