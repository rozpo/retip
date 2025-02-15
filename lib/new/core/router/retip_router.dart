import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/home_page.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
      : super.routingConfig(
          initialLocation: '/',
          routingConfig: ValueNotifier(
            RoutingConfig(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
          ),
        );
}
