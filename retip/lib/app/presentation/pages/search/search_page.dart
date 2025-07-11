import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: SearchBar(
          hintText: 'Search for...',
          // leading: Icon(Icons.search),
          trailing: [Icon(Icons.mic)],
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(RetipRoutes.profile),
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: IconButton.filled(
                      onPressed: null,
                      icon: Icon(Icons.music_note_outlined),
                    ),
                    title: Text('Track $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
