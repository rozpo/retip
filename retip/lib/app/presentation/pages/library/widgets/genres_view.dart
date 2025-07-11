import 'package:flutter/material.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(index.toString())),
          title: Text('Genres $index'),
        );
      },
    );
  }
}
