import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/logger/retip_logger.dart';

void main() {
  debugRepaintRainbowEnabled = kDebugMode;
  debugInvertOversizedImages = kDebugMode;

  RetipLogger().info('App started!');

  final app = const RetipApp();

  runApp(app);
}
