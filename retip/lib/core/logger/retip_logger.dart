import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'dart:developer' show log;

class RetipLogger extends Talker {
  RetipLogger() : super(logger: TalkerLogger(output: _defaultFlutterOutput));

  NavigatorObserver get navigatorObserver => TalkerRouteObserver(this);

  Widget get widget => TalkerScreen(talker: this);

  static void _defaultFlutterOutput(String message) {
    if (kIsWeb) {
      // ignore: avoid_print
      print(message);
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        log(message, name: 'Talker');
        break;
      default:
        debugPrint(message);
    }
  }
}
