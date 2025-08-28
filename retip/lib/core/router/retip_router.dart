import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/blocs/permissions/permissions_bloc.dart';
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
  final PermissionsBloc permissionsBloc;

  RetipRouter(this.onboardingBloc, this.permissionsBloc)
    : super.routingConfig(
        initialLocation: '/',
        refreshListenable: MultiBlocListenable({
          "OnboardingBloc": onboardingBloc.stream,
          "PermissionsBloc": permissionsBloc.stream,
        }),
        routingConfig: ValueNotifier(
          RoutingConfig(
            redirect: (context, state) async {
              if (onboardingBloc.state is! OnboardingCompletedState) {
                return '/onboarding';
              }

              if (permissionsBloc.state is! PermissionsGrantedState) {
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

class MultiBlocListenable extends ChangeNotifier {
  final Map<String, StreamSubscription> _subscriptions = {};

  MultiBlocListenable(Map<String, Stream> namedStreams) {
    notifyListeners();

    namedStreams.forEach((name, stream) {
      _subscriptions[name] = stream.asBroadcastStream().listen((_) {
        debugPrint('MultiBlocListenable: $name stream emitted');
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    for (var subscription in _subscriptions.values) {
      subscription.cancel();
    }
    super.dispose();
  }
}
