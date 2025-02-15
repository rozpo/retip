import 'package:flutter/material.dart';
import 'package:retip/new/core/l10n/retip_l10n.dart';

import 'app/retip_app.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  // Core dependencies
  final retipRouter = RetipRouter();
  final retipTheme = RetipTheme();
  final retipL10n = RetipL10n();

  final retipApp = RetipApp(
    retipRouter: retipRouter,
    retipTheme: retipTheme,
    retipL10n: retipL10n,
  );

  runApp(retipApp);
}
