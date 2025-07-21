import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../core/logger/retip_logger.dart';

class LoggerPage extends StatelessWidget {
  const LoggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = GetIt.I.get<RetipLogger>();

    return logger.widget;
  }
}
