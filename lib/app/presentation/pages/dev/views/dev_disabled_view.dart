import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevDisabledView extends StatelessWidget {
  const DevDisabledView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Developer mode not enabled'),
            SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
