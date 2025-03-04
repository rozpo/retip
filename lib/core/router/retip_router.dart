import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/facades/intro_facade.dart';
import '../../app/presentation/pages/home/home_page.dart';
import '../../app/presentation/pages/intro/intro_page.dart';

mixin RetipRouter {
  static final router = GoRouter(
    redirect: (context, state) {
      return context.read<IntroFacade>().isIntroPageEnabled() ? '/intro' : null;
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
