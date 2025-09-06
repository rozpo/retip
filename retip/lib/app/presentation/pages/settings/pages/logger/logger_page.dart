import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/core/logger/retip_logger.dart';

class LoggerPage extends StatelessWidget {
  const LoggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<RetipLogger>().widget;
  }
}
