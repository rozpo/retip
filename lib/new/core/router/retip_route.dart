import 'package:go_router/go_router.dart';

class RetipRoute extends GoRoute {
  static const String home = '/';
  static const String permission = '/permission';

  RetipRoute({
    required super.path,
    required super.builder,
  });
}
