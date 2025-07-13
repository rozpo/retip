import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/album_page.dart';
import '../../app/presentation/pages/artist_page.dart';
import '../../app/presentation/pages/developer_page.dart';
import '../../app/presentation/pages/error_page.dart';
import '../../app/presentation/pages/genre_page.dart';
import '../../app/presentation/pages/history_page.dart';
import '../../app/presentation/pages/home_page.dart';
import '../../app/presentation/pages/library_page.dart';
import '../../app/presentation/pages/logger_page.dart';
import '../../app/presentation/pages/onboarding_page.dart';
import '../../app/presentation/pages/permissions_page.dart';
import '../../app/presentation/pages/player_page.dart';
import '../../app/presentation/pages/playlist_page.dart';
import '../../app/presentation/pages/profile_page.dart';
import '../../app/presentation/pages/search_page.dart';
import '../../app/presentation/pages/settings_page.dart';
import '../../app/presentation/pages/storage_page.dart';
import '../../app/presentation/pages/track_page.dart';
import '../../app/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'retip_routes.dart';

final class RetipRouter extends GoRouter {
  static final _onboarding = GoRoute(
    builder: (context, state) => const OnboardingPage(),
    path: RetipRoutes.onboarding,
  );

  static final _permissions = GoRoute(
    builder: (context, state) => const PermissionsPage(),
    path: RetipRoutes.permissions,
  );

  static final _home = GoRoute(
    builder: (context, state) => const HomePage(),
    path: RetipRoutes.home,
  );

  static final _search = GoRoute(
    builder: (context, state) => const SearchPage(),
    path: RetipRoutes.search,
  );

  static final _library = GoRoute(
    builder: (context, state) => const LibraryPage(),
    path: RetipRoutes.library,
  );

  static final _profile = GoRoute(
    builder: (context, state) => const ProfilePage(),
    path: RetipRoutes.profile,
  );

  static final _history = GoRoute(
    builder: (context, state) => const HistoryPage(),
    path: RetipRoutes.history,
  );

  static final _storage = GoRoute(
    builder: (context, state) => const StoragePage(),
    path: RetipRoutes.storage,
  );

  static final _settings = GoRoute(
    builder: (context, state) => const SettingsPage(),
    path: RetipRoutes.settings,
  );

  static final _developer = GoRoute(
    builder: (context, state) => const DeveloperPage(),
    path: RetipRoutes.developer,
  );

  static final _logger = GoRoute(
    builder: (context, state) => const LoggerPage(),
    path: RetipRoutes.logger,
  );

  static final _player = GoRoute(
    builder: (context, state) => const PlayerPage(),
    path: RetipRoutes.player,
  );

  static final _playlist = GoRoute(
    name: RetipRoutes.playlist,
    path: RetipRoutes.playlist,
    builder: (context, state) => PlaylistPage(
      id: int.parse(state.pathParameters['id'] as String),
    ),
  );

  static final _genre = GoRoute(
    name: RetipRoutes.genre,
    path: RetipRoutes.genre,
    builder: (context, state) => GenrePage(
      id: int.parse(state.pathParameters['id'] as String),
    ),
  );

  static final _artist = GoRoute(
    name: RetipRoutes.artist,
    path: RetipRoutes.artist,
    builder: (context, state) => ArtistPage(
      id: int.parse(state.pathParameters['id'] as String),
    ),
  );

  static final _album = GoRoute(
    name: RetipRoutes.album,
    path: RetipRoutes.album,
    builder: (context, state) => AlbumPage(
      id: int.parse(state.pathParameters['id'] as String),
    ),
  );

  static final _track = GoRoute(
    name: RetipRoutes.track,
    path: RetipRoutes.track,
    builder: (context, state) => TrackPage(
      id: int.parse(state.pathParameters['id'] as String),
    ),
  );

  static bool isOnboardingFinished = false;
  static bool isPermissionsGranted = false;

  RetipRouter()
      : super.routingConfig(
          errorBuilder: (context, state) => const ErrorPage(),
          initialLocation: RetipRoutes.home,
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: (context, state) {
                if (isOnboardingFinished == false) {
                  return RetipRoutes.onboarding;
                } else if (isPermissionsGranted == false) {
                  return RetipRoutes.permissions;
                } else {
                  return null;
                }
              },
              routes: [
                _onboarding,
                _permissions,
                ShellRoute(
                  builder: (context, state, child) {
                    return BottomNavigationBarWidget(
                      child: child,
                    );
                  },
                  routes: [
                    _home,
                    _search,
                    _library,
                    _playlist,
                    _genre,
                    _artist,
                    _album,
                    _track,
                  ],
                ),
                _profile,
                _history,
                _storage,
                _settings,
                _developer,
                _logger,
                _player,
              ],
            ),
          ),
        );
}
