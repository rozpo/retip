import 'dart:async';

import 'package:flutter/foundation.dart';
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

  static final _dev = GoRoute(
    path: '/dev',
    builder: (context, state) {
      return DevPage();
    },
  );

  static bool permissionsGranted = false;

  final OnboardingBloc onboardingBloc;

  RetipRouter(this.onboardingBloc)
    : super.routingConfig(
        initialLocation: '/',
        refreshListenable: BlocListenable(onboardingBloc.stream),
        routingConfig: ValueNotifier(
          RoutingConfig(
            redirect: (context, state) async {
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
              _dev,
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

class BlocListenable extends ChangeNotifier {
  late final StreamSubscription _subscription;

  BlocListenable(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
