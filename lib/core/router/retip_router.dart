import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/pages.dart';
import '../../app/presentation/views/navigation_view.dart';

bool showOnboarding = true;
bool hasPermission = false;

class RetipRouter extends GoRouter {
  // Routes
  static const home = '/';
  static const explore = '/explore';
  static const library = '/library';
  static const search = '/search';
  static const profile = '/profile';

  static const artist = '/artist/:id';
  static const album = '/album/:id';
  static const playlist = '/playlist/:id';
  static const genre = '/genre/:id';

  static const player = '/player';
  static const permission = '/permission';
  static const onboarding = '/onboarding';
  static const settings = '/settings';

  // Route definitions
  static final _home = GoRoute(
    builder: (context, state) => const HomePage(),
    path: home,
  );

  static final _explore = GoRoute(
    builder: (context, state) => const ExplorePage(),
    path: explore,
  );

  static final _search = GoRoute(
    builder: (context, state) => const SearchPage(),
    path: search,
  );

  static final _library = GoRoute(
    builder: (context, state) => const LibraryPage(),
    path: library,
  );

  static final _profile = GoRoute(
    builder: (context, state) => const ProfilePage(),
    path: profile,
  );

  static final _artist = GoRoute(
    path: artist,
    name: artist,
    builder: (context, state) {
      final id = state.pathParameters['id'];
      return ArtistPage(int.parse(id!));
    },
  );

  static final _album = GoRoute(
    path: album,
    name: album,
    builder: (context, state) {
      final id = state.pathParameters['id'];
      return AlbumPage(int.parse(id!));
    },
  );

  static final _playlist = GoRoute(
    path: playlist,
    name: playlist,
    builder: (context, state) {
      final id = state.pathParameters['id'];
      return PlaylistPage(int.parse(id!));
    },
  );

  static final _genre = GoRoute(
    path: genre,
    name: genre,
    builder: (context, state) {
      final id = state.pathParameters['id'];
      return GenrePage(int.parse(id!));
    },
  );

  static final _settings = GoRoute(
    path: settings,
    builder: (context, state) => const SettingsPage(),
  );

  static final _player = GoRoute(
    path: player,
    builder: (context, state) => const PlayerPage(),
  );

  static final _permission = GoRoute(
    path: permission,
    builder: (context, state) => const PermissionPage(),
  );

  static final _onboarding = GoRoute(
    path: onboarding,
    builder: (context, state) => const OnboardingPage(),
  );

  // Constructor
  RetipRouter()
      : super.routingConfig(
          debugLogDiagnostics: kDebugMode,
          initialLocation: home,
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: (context, state) async {
                if (showOnboarding) return RetipRouter.onboarding;
                return hasPermission == false ? RetipRouter.permission : null;
              },
              routes: [
                _onboarding,
                _permission,
                _player,
                _settings,
                ShellRoute(
                  builder: (context, state, child) {
                    return Scaffold(
                      bottomNavigationBar: const NavigationView(),
                      body: child,
                    );
                  },
                  routes: [
                    _home,
                    _explore,
                    _search,
                    _library,
                    _profile,
                    _artist,
                    _album,
                    _playlist,
                    _genre,
                  ],
                ),
              ],
            ),
          ),
        );
}
