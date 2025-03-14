import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/repositories/permission_repository.dart';
import '../../app/presentation/cubits/onboarding/onboarding_cubit.dart';
import '../../app/presentation/pages/album_page.dart';
import '../../app/presentation/pages/explore_page.dart';
import '../../app/presentation/pages/genre_page.dart';
import '../../app/presentation/pages/home_page.dart';
import '../../app/presentation/pages/library_page.dart';
import '../../app/presentation/pages/onboarding_page.dart';
import '../../app/presentation/pages/permission_page.dart';
import '../../app/presentation/pages/player_page.dart';
import '../../app/presentation/pages/playlist_page.dart';
import '../../app/presentation/pages/profile_page.dart';
import '../../app/presentation/pages/search_page.dart';
import '../../app/presentation/views/navigation_view.dart';
import 'retip_routes.dart';

class RetipRouter extends GoRouter {
  static final _onboarding = GoRoute(
    builder: (context, state) => const OnboardingPage(),
    path: RetipRoutes.onboarding,
  );

  static final _permission = GoRoute(
    builder: (context, state) => const PermissionPage(),
    path: RetipRoutes.permission,
  );

  static final _player = GoRoute(
    builder: (context, state) => const PlayerPage(),
    path: RetipRoutes.player,
  );

  static final _home = GoRoute(
    builder: (context, state) => const HomePage(),
    path: RetipRoutes.home,
  );

  static final _explore = GoRoute(
    builder: (context, state) => const ExplorePage(),
    path: RetipRoutes.explore,
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

  static final _genre = GoRoute(
    path: RetipRoutes.genre,
    name: RetipRoutes.genre,
    builder: (context, state) {
      final genreId = state.pathParameters['id']!;
      return GenrePage(int.parse(genreId));
    },
  );

  static final _album = GoRoute(
    path: RetipRoutes.album,
    name: RetipRoutes.album,
    builder: (context, state) {
      final albumId = state.pathParameters['id']!;
      return AlbumPage(int.parse(albumId));
    },
  );

  static final _playlist = GoRoute(
    path: RetipRoutes.playlist,
    name: RetipRoutes.playlist,
    builder: (context, state) {
      final playlistId = state.pathParameters['id']!;
      return PlaylistPage(int.parse(playlistId));
    },
  );

  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final permissionRepository = context.read<PermissionRepository>();
    final onboardingCubit = context.read<OnboardingCubit>();

    if (onboardingCubit.state is! OnboardingFinished) {
      return RetipRoutes.onboarding;
    }

    if (await permissionRepository.getMediaPermissionStatus() == false) {
      return RetipRoutes.permission;
    }

    return null;
  }

  RetipRouter()
      : super.routingConfig(
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: _redirect,
              routes: [
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
                    _album,
                    _genre,
                    _playlist,
                  ],
                ),
                _onboarding,
                _permission,
                _player,
              ],
            ),
          ),
        );
}
