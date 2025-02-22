import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/library_page.dart';
import 'retip_route.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
      : super.routingConfig(
          initialLocation: RetipRoute.home,
          routingConfig: ValueNotifier(
            RoutingConfig(
              routes: [
                ShellRoute(
                  builder: (context, state, child) {
                    return Scaffold(
                      body: child,
                      bottomNavigationBar: Container(
                        color: Colors.red,
                        height: 100,
                      ),
                    );
                  },
                  routes: [
                    RetipRoute(
                      path: RetipRoute.home,
                      builder: (context, state) {
                        return const LibraryPage();
                      },
                    )
                  ],
                ),
                RetipRoute(
                  path: RetipRoute.permission,
                  builder: (context, state) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Permission'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
}
