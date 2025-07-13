import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/home_page.dart';
import 'retip_routes.dart';

final class RetipRouter extends GoRouter {
  static final _home = GoRoute(
    builder: (context, state) => const HomePage(),
    path: RetipRoutes.home,
  );

  RetipRouter()
      : super.routingConfig(
          initialLocation: RetipRoutes.home,
          routingConfig: ValueNotifier(
            RoutingConfig(
              routes: [
                _home,
              ],
            ),
          ),
        );
}
