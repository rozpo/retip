import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/usecases/permission_usecase.dart';
import '../../app/presentation/pages/library_page.dart';
import '../../app/presentation/pages/permission/permission_page.dart';
import 'retip_route.dart';

class RetipRouter extends GoRouter {
  static final rootNavKey = GlobalKey<NavigatorState>();
  static final shellNavKey = GlobalKey<NavigatorState>();

  RetipRouter()
      : super.routingConfig(
          navigatorKey: rootNavKey,
          initialLocation: RetipRoute.home,
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: (context, state) async {
                final usecase = context.read<PermissionUsecase>();
                final hasPermission = await usecase.hasMediaPermission();

                return hasPermission == false ? RetipRoute.permission : null;
              },
              routes: [
                ShellRoute(
                  navigatorKey: shellNavKey,
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
                    return const PermissionPage();
                  },
                ),
              ],
            ),
          ),
        );
}
