import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library Page')),
      body: Center(child: Text('Welcome to the Library')),
    );
  }
}
