import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/cubits/permission/permission_cubit.dart';
import '../../app/presentation/pages/album/album_page.dart';
import '../../app/presentation/pages/artist/artist_page.dart';
import '../../app/presentation/pages/explore/explore_page.dart';
import '../../app/presentation/pages/genre/genre_page.dart';
import '../../app/presentation/pages/home/home_page.dart';
import '../../app/presentation/pages/library/library_page.dart';
import '../../app/presentation/pages/permission/permission_page.dart';
import '../../app/presentation/pages/player/player_page.dart';
import '../../app/presentation/pages/playlist/playlist_page.dart';
import '../../app/presentation/pages/profile/profile_page.dart';
import '../../app/presentation/pages/search/search_page.dart';

class RetipRouter extends GoRouter {
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _shellNavKey = GlobalKey<NavigatorState>();

  static const _homePath = '/';
  static const _permissionPath = '/permission';
  static const _playerPath = '/player';
  static const _searchPath = '/search';
  static const _explorePath = '/explore';
  static const _libraryPath = '/library';
  static const _profilePath = '/profile';
  static const _artistPath = '/artist';
  static const _albumPath = '/album';
  static const _playlistPath = '/playlist';
  static const _genrePath = '/genre';

  String get home => _homePath;
  String get permission => _permissionPath;
  String get player => _playerPath;
  String get search => _searchPath;
  String get explore => _explorePath;
  String get library => _libraryPath;
  String get profile => _profilePath;
  String get artist => _artistPath;
  String get album => _albumPath;
  String get playlist => _playlistPath;
  String get genre => _genrePath;

  static final _homeRoute = GoRoute(
    path: _homePath,
    builder: (context, state) => const HomePage(),
  );

  static final _permissionRoute = GoRoute(
    path: _permissionPath,
    builder: (context, state) => const PermissionPage(),
  );

  static final _playerRoute = GoRoute(
    path: _playerPath,
    builder: (context, state) => const PlayerPage(),
  );

  static final _searchRoute = GoRoute(
    path: _searchPath,
    builder: (context, state) => const SearchPage(),
  );

  static final _exploreRoute = GoRoute(
    path: _explorePath,
    builder: (context, state) => const ExplorePage(),
  );

  static final _libraryRoute = GoRoute(
    path: _libraryPath,
    builder: (context, state) => const LibraryPage(),
  );

  static final _profileRoute = GoRoute(
    path: _profilePath,
    builder: (context, state) => const ProfilePage(),
  );
  static final _artistRoute = GoRoute(
    path: _artistPath,
    builder: (context, state) => const ArtistPage(),
  );
  static final _albumRoute = GoRoute(
    path: _albumPath,
    builder: (context, state) => const AlbumPage(),
  );
  static final _playlistRoute = GoRoute(
    path: _playlistPath,
    builder: (context, state) => const PlaylistPage(),
  );
  static final _genreRoute = GoRoute(
    path: _genrePath,
    builder: (context, state) => const GenrePage(),
  );

  RetipRouter()
      : super.routingConfig(
          initialLocation: _homePath,
          navigatorKey: _rootNavKey,
          routingConfig: ValueNotifier(
            RoutingConfig(
              routes: [
                ShellRoute(
                  navigatorKey: _shellNavKey,
                  routes: [
                    _homeRoute,
                    _exploreRoute,
                    _searchRoute,
                    _libraryRoute,
                    _profileRoute,
                    _artistRoute,
                    _albumRoute,
                    _playlistRoute,
                    _genreRoute,
                  ],
                  builder: (context, state, child) {
                    return Scaffold(
                      body: child,
                      bottomNavigationBar: BottomNavigationBar(
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.explore),
                            label: 'Explore',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.search),
                            label: 'Search',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.library_music),
                            label: 'Library',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: 'Profile',
                          ),
                        ],
                        onTap: (value) {
                          switch (value) {
                            case 0:
                              context.go(_homePath);
                              break;
                            case 1:
                              context.go(_explorePath);
                              break;
                            case 2:
                              context.go(_searchPath);
                              break;
                            case 3:
                              context.go(_libraryPath);
                              break;
                            case 4:
                              context.go(_profilePath);
                              break;
                          }
                        },
                      ),
                    );
                  },
                ),
                _permissionRoute,
                _playerRoute,
              ],
              redirect: (context, state) {
                final cubit = context.read<PermissionCubit>();
                if (cubit.state.isGranted) {
                  return null;
                }
                return _permissionPath;
              },
            ),
          ),
        );
}
