import 'package:flutter/material.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(index.toString())),
          title: Text('Track $index'),
          subtitle: Text('Artist ${index % 10}'),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline),
          ),
          // trailing: Text('03:43'),
        );
      },
    );
  }
}
