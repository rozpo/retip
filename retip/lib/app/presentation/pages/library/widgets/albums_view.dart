import 'package:flutter/material.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(index.toString())),
          title: Text('Album $index'),
        );
      },
    );
  }
}
