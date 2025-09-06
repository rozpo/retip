import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin RetipRoute {
  static const onboarding = '/onboarding';
  static const permissions = '/permissions';
  static const home = '/';
  static const library = '/library';
  static const search = '/search';
  static const settings = '/settings';

  static void go(BuildContext context, String location) {
    context.go(location);
  }

  static void push(BuildContext context, String location) {
    context.push(location);
  }
}
