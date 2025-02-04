import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/pages/dev/dev_page.dart';
import 'package:retip/app/presentation/pages/home/home_page.dart';
import 'package:retip/app/presentation/pages/intro/intro_page.dart';
import 'package:retip/app/presentation/widgets/organisms/player_widget.dart';
import 'package:retip/core/constants/routes_constants.dart';

import '../../app/presentation/pages/home/cubit/home_cubit.dart';
import '../../app/presentation/views/search/bloc/search_bloc.dart';
import '../../app/presentation/widgets/widgets.dart';

mixin RetipRouter {
  static final rootNavKey = GlobalKey<NavigatorState>();
  static final shellNavKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: RoutesConstants.intro,
    routes: [
      GoRoute(
        path: RoutesConstants.intro,
        builder: (context, state) {
          return const IntroPage();
        },
      ),
      ShellRoute(
        navigatorKey: shellNavKey,
        routes: [
          GoRoute(
            path: RoutesConstants.home,
            builder: (context, state) {
              return const HomePage();
            },
            routes: [
              if (kReleaseMode == false) ...[
                GoRoute(
                  path: RoutesConstants.dev,
                  builder: (context, state) {
                    return const DevPage();
                  },
                ),
              ],
            ],
          ),
        ],
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PlayerWidget(),
                BottomNavigationBarWidget(
                  onTap: (value) {
                    final bloc = context.read<HomeCubit?>();

                    if (bloc?.state.index == value && value == 2) {
                      context.read<SearchBloc>().state.focusNode.requestFocus();
                    } else {
                      bloc?.goToPage(value);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
