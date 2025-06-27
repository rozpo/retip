import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:retip/core/utils/run_mode.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RetipLogger {
  final Talker _talker;

  RetipLogger()
    : _talker = TalkerFlutter.init(
        logger: TalkerLogger(
          settings: TalkerLoggerSettings(
            level: RunMode.isRelease ? LogLevel.info : LogLevel.verbose,
          ),
        ),
      );

  Widget get widget => TalkerScreen(talker: _talker);

  NavigatorObserver get navigatorObserver => TalkerRouteObserver(_talker);

  BlocObserver get blocObserver => TalkerBlocObserver(
    talker: _talker,

    settings: TalkerBlocLoggerSettings(
      enabled: true,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
    ),
  );

  Widget wrapper({required Widget child}) => TalkerWrapper(
    talker: _talker,
    options: TalkerWrapperOptions(enableErrorAlerts: true),
    child: child,
  );

  void verbose(String msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.verbose(msg, exception, stackTrace);
  }

  void debug(String msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.debug(msg, exception, stackTrace);
  }

  void info(String msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.info(msg, exception, stackTrace);
  }

  void warning(String msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.warning(msg, exception, stackTrace);
  }

  void error(String msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.error(msg, exception, stackTrace);
  }

  void critical(String msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.critical(msg, exception, stackTrace);
  }
}
