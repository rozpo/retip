import 'package:flutter/material.dart';

class TrackPage extends StatelessWidget {
  final int id;

  const TrackPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track $id'),
      ),
    );
  }
}
