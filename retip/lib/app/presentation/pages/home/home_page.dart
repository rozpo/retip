import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
    );
  }
}
