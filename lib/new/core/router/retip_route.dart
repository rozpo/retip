import 'package:go_router/go_router.dart';

class RetipRoute extends GoRoute {
  static const String onboarding = '/intro';
  static const String permission = '/permission';

  static const String home = '/';
  static const String explore = '/explore';
  static const String search = '/search';
  static const String settings = '/settings';
  static const String library = '/library';

  RetipRoute({
    required super.path,
    required super.builder,
  });
}
