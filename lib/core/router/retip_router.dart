import 'package:go_router/go_router.dart';
import 'package:retip/app/views/home/home_view.dart';
import 'package:retip/app/views/into/intro_view.dart';

mixin RetipRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/intro',
    routes: [
      GoRoute(
        path: '/intro',
        builder: (context, state) {
          return const IntroView();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomeView();
        },
      ),
    ],
  );
}
