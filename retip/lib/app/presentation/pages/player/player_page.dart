import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player Page')),
      body: Center(child: Text('Now Playing: Song Title')),
    );
  }
}
