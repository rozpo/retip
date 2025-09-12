import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

enum RetipRoute {
  onboarding(),
  permissions(),
  home(),
  library(),
  album([RetipRoute.library]),
  artist([RetipRoute.library]),
  search(),
  profile(),
  settings([RetipRoute.profile]),
  appinfo([RetipRoute.profile]),
  dev([RetipRoute.profile, RetipRoute.settings]),
  logger([RetipRoute.profile, RetipRoute.settings]);

  final List<RetipRoute> parents;

  const RetipRoute([this.parents = const []]);

  String get location {
    final string = p.join('/', p.joinAll(parents.map((e) => e.name)), name);
    return string;
  }

  void go(BuildContext context) {
    context.goNamed(name);
  }

  void push(
    BuildContext context, {
    Map<String, String> pathParameters = const {},
  }) {
    context.pushNamed(name, pathParameters: pathParameters);
  }

  void pushReplace(
    BuildContext context, {
    Map<String, String> pathParameters = const {},
  }) {
    context.pushReplacementNamed(name, pathParameters: pathParameters);
  }
}
