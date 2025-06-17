import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:retip/app/retip_app.dart';
import 'package:retip/core/logger/retip_logger.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/theme/retip_theme.dart';

void main() {
  debugRepaintRainbowEnabled = kDebugMode;
  debugInvertOversizedImages = kDebugMode;

  RetipLogger().info('App started!');

  final router = RetipRouter();
  final theme = RetipTheme();

  final app = RetipApp(router: router, theme: theme);

  runApp(app);
}
