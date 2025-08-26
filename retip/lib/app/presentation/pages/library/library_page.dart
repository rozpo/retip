import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.library_music),
        title: Text('Library'),
      ),
      body: Center(child: Text('Library content goes here')),
    );
  }
}
