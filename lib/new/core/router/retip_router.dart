import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/home_page.dart';
import '../../app/presentation/pages/intro_page.dart';

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
                GoRoute(
                  path: '/intro',
                  builder: (context, state) => const IntroPage(),
                ),
              ],
              redirect: (context, state) {
                if (Random().nextBool()) {
                  return '/intro';
                }
                return null;
              },
            ),
          ),
        );
}
