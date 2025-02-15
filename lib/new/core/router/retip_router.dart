import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/home_page.dart';
import '../../app/presentation/pages/permission_page.dart';

class RetipRouter extends GoRouter {
  static const _homePath = '/';
  String get home => _homePath;

  static final _homeRoute = GoRoute(
    path: _homePath,
    builder: (context, state) => const HomePage(),
  );

  static const _permissionPath = '/permission';
  String get permission => _permissionPath;

  static final _permissionRoute = GoRoute(
    path: _permissionPath,
    builder: (context, state) => const PermissionPage(),
  );

  RetipRouter()
      : super.routingConfig(
          initialLocation: _homePath,
          routingConfig: ValueNotifier(
            RoutingConfig(
              routes: [
                _homeRoute,
                _permissionRoute,
              ],
              redirect: (context, state) {
                if (Random().nextBool()) {
                  return _permissionPath;
                }
                return null;
              },
            ),
          ),
        );
}
