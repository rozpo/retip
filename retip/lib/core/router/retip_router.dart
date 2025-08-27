import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/layout/retip_layout.dart';

import '../../app/presentation/blocs/onboarding/onboarding_bloc.dart';
import '../../app/presentation/pages/pages.dart';

class RetipRouter extends GoRouter {
  static final _onboarding = GoRoute(
    path: '/onboarding',
    builder: (context, state) {
      return OnboardingPage();
    },
  );

  static final _permissions = GoRoute(
    path: '/permissions',
    builder: (context, state) {
      return PermissionsPage();
    },
  );

  static final _home = GoRoute(
    path: '/',
    builder: (context, state) {
      return HomePage();
    },
  );

  static final _search = GoRoute(
    path: '/search',
    builder: (context, state) {
      return SearchPage();
    },
  );

  static final _library = GoRoute(
    path: '/library',
    builder: (context, state) {
      return LibraryPage();
    },
  );

  static final _profile = GoRoute(
    path: '/profile',
    builder: (context, state) {
      return ProfilePage();
    },
  );

  static final _player = GoRoute(
    path: '/player',
    builder: (context, state) {
      return PlayerPage();
    },
  );

  static final _settings = GoRoute(
    path: '/settings',
    builder: (context, state) {
      return SettingsPage();
    },
  );

  static bool permissionsGranted = false;

  RetipRouter()
    : super.routingConfig(
        initialLocation: '/',

        routingConfig: ValueNotifier(
          RoutingConfig(
            redirect: (context, state) async {
              final onboardingBloc = context.read<OnboardingBloc>();

              if (onboardingBloc.state is! OnboardingCompletedState) {
                return '/onboarding';
              }

              if (permissionsGranted == false) {
                return '/permissions';
              }
              return null;
            },
            routes: [
              _onboarding,
              _permissions,
              _player,
              _profile,
              _settings,
              ShellRoute(
                builder: (context, state, child) {
                  return RetipLayout(body: child);
                },
                routes: [_home, _search, _library],
              ),
            ],
          ),
        ),
      );
}
