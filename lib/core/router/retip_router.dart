import 'package:go_router/go_router.dart';
import 'package:retip/app/views/home/home_view.dart';

mixin RetipRouter {
  static GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
          ),
        ],
      );
}
