import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  final int id;

  const AlbumPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album $id'),
      ),
    );
  }
}
