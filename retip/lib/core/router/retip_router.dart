import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/pages.dart';

class RetipRouter extends GoRouter {
  static final _home = GoRoute(
    path: '/',
    builder: (context, state) {
      return HomePage();
    },
  );

  RetipRouter()
    : super.routingConfig(
        initialLocation: '/',
        routingConfig: ValueNotifier(RoutingConfig(routes: [_home])),
      );
}
