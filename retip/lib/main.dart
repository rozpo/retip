import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'app/retip_app.dart';
import 'core/logger/retip_logger.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() {
  debugRepaintRainbowEnabled = kDebugMode;
  debugInvertOversizedImages = kDebugMode;

  RetipLogger().info('App started!');

  final router = RetipRouter();
  final theme = RetipTheme();

  final app = RetipApp(router: router, theme: theme);

  runApp(app);
}
