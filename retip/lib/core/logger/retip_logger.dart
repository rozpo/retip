import 'package:talker_flutter/talker_flutter.dart';

class RetipLogger {
  static final RetipLogger _instance = RetipLogger._();

  final Talker talker;

  factory RetipLogger() => _instance;

  RetipLogger._() : talker = TalkerFlutter.init();

  void verbose(String msg, [Object? exception, StackTrace? stackTrace]) {
    talker.verbose(msg, exception, stackTrace);
  }

  void debug(String msg, [Object? exception, StackTrace? stackTrace]) {
    talker.debug(msg, exception, stackTrace);
  }

  void info(String msg, [Object? exception, StackTrace? stackTrace]) {
    talker.info(msg, exception, stackTrace);
  }

  void warning(String msg, [Object? exception, StackTrace? stackTrace]) {
    talker.warning(msg, exception, stackTrace);
  }

  void error(String msg, [Object? exception, StackTrace? stackTrace]) {
    talker.error(msg, exception, stackTrace);
  }

  void critical(String msg, [Object? exception, StackTrace? stackTrace]) {
    talker.critical(msg, exception, stackTrace);
  }
}
