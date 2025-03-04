import 'package:flutter/material.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Page'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {},
          child: const Text('Allow Permission'),
        ),
      ),
    );
  }
}
