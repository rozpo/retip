import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/router/retip_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () => context.push(RetipRoutes.profile),
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Placeholder(),
    );
  }
}
