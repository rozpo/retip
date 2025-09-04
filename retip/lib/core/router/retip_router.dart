import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
    : super.routingConfig(
        routingConfig: ValueNotifier(
          RoutingConfig(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return Scaffold(
                    body: Center(child: Text(RetipL10n.of(context).helloWorld)),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
