import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RetipLogger {
  static final RetipLogger _instance = RetipLogger._();

  final Talker _talker;

  factory RetipLogger() => _instance;

  RetipLogger._() : _talker = TalkerFlutter.init();

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

  Widget get widget => TalkerScreen(talker: _talker);
}
