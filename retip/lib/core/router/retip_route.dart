import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

enum RetipRoute {
  onboarding(),
  permissions(),
  home(),
  library(),
  search(),
  settings(),
  dev([RetipRoute.settings]),
  logger([RetipRoute.settings]);

  final List<RetipRoute> parents;

  const RetipRoute([this.parents = const []]);

  String get location {
    return p.join('/', p.joinAll(parents.map((e) => e.name)), name);
  }

  void go(BuildContext context) {
    context.goNamed(name);
  }

  void push(BuildContext context) {
    context.pushNamed(name);
  }
}
