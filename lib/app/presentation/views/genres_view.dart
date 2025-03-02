import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.category),
          title: Text('Genre $index'),
          onTap: () => context.pushNamed(
            pathParameters: {'id': '$index'},
            RetipRouter.genre,
          ),
        );
      },
    );
  }
}
