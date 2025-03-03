import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/usecases/intro_usecases.dart';
import '../../app/presentation/pages/home/home_page.dart';
import '../../app/presentation/pages/intro/intro_page.dart';

mixin RetipRouter {
  static final router = GoRouter(
    redirect: (context, state) {
      final isIntroPageEnabled =
          GetIt.I.get<IntroUsecases>().isIntroPageEnabled();

      if (isIntroPageEnabled) {
        return '/intro';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/intro',
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
