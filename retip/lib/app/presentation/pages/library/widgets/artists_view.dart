import 'package:flutter/material.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(index.toString())),
          title: Text('Artist $index'),
        );
      },
    );
  }
}
