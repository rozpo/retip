import 'package:flutter/material.dart';

class ArtistPage extends StatelessWidget {
  final int id;

  const ArtistPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artist Page $id'),
      ),
    );
  }
}
