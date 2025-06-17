import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/pages/home/home_page.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
    : super.routingConfig(
        initialLocation: '/',
        routingConfig: ValueNotifier(
          RoutingConfig(
            routes: [
              GoRoute(path: '/', builder: (context, state) => HomePage()),
            ],
          ),
        ),
      );
}
