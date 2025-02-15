import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
      : super.routingConfig(
          initialLocation: '/',
          routingConfig: ValueNotifier(
            RoutingConfig(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const Scaffold(
                    body: Center(
                      child: Text('Home'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
