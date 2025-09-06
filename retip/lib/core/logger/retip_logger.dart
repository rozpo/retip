import 'dart:developer' show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RetipLogger extends Talker {
  RetipLogger() : super(logger: TalkerLogger(output: _defaultFlutterOutput));

  NavigatorObserver get navigatorObserver => TalkerRouteObserver(this);

  BlocObserver get blocObserver => TalkerBlocObserver(talker: this);

  Widget get widget {
    return TalkerScreen(
      isLogsExpanded: false,
      appBarTitle: 'Logger',
      talker: this,
    );
  }

  Widget wrapper({required Widget child}) {
    return TalkerWrapper(
      options: TalkerWrapperOptions(
        enableExceptionAlerts: true,
        exceptionAlertBuilder: (context, data) {
          return Container(
            color: Colors.red,
            child: Center(child: Text(data.displayException)),
          );
        },
        enableErrorAlerts: true,
        errorAlertBuilder: (context, data) {
          return Container(
            color: Colors.red,
            child: Center(child: Text(data.displayError)),
          );
        },
      ),

      talker: this,
      child: child,
    );
  }

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
