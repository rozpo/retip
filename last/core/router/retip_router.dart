import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/repositories/config_repository.dart';
import '../../app/presentation/pages/home/home_page.dart';
import '../../app/presentation/pages/intro/intro_page.dart';

mixin RetipRouter {
  static final router = GoRouter(
    redirect: (context, state) {
      return context.read<ConfigRepository>().getOnboardingValue()
          ? '/intro'
          : null;
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
