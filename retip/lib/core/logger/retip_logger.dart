import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

mixin RetipLogger {
  static late final Talker _talker;

  static void init() {
    _talker = TalkerFlutter.init();
    Bloc.observer = TalkerBlocObserver(talker: _talker);
  }

  static Widget get widget => TalkerScreen(talker: _talker);

  static NavigatorObserver navigatorObserver = TalkerRouteObserver(_talker);

  static NavigatorObserver shellNavigatorObserver = TalkerRouteObserver(
    _talker,
  );

  static void critical(String msg, [Object? error, StackTrace? stackTrace]) {
    _talker.critical(msg, error, stackTrace);
  }

  static void error(String msg, [Object? error, StackTrace? stackTrace]) {
    _talker.error(msg, error, stackTrace);
  }

  static void warning(String msg, [Object? error, StackTrace? stackTrace]) {
    _talker.warning(msg, error, stackTrace);
  }

  static void info(String msg, [Object? error, StackTrace? stackTrace]) {
    _talker.info(msg, error, stackTrace);
  }

  static void debug(String msg, [Object? error, StackTrace? stackTrace]) {
    _talker.debug(msg, error, stackTrace);
  }

  static void verbose(String msg, [Object? error, StackTrace? stackTrace]) {
    _talker.verbose(msg, error, stackTrace);
  }
}
