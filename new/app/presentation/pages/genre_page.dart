import 'package:flutter/material.dart';

class GenrePage extends StatelessWidget {
  final int id;

  const GenrePage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre $id'),
      ),
    );
  }
}
