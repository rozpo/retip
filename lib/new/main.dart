import 'package:flutter/material.dart';

import 'app/presentation/cubits/theme/theme_cubit.dart';
import 'app/retip_app.dart';
import 'core/l10n/retip_l10n.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';
import 'core/theme/src/button_theme.dart';

void main() async {
  // Core dependencies
  final retipRouter = RetipRouter();
  final retipL10n = RetipL10n();

  final retipTheme = RetipTheme(
    retipButtonTheme: RetipButtonTheme(),
  );

  // Cubit dependencies
  final themeCubit = ThemeCubit();

  final retipApp = RetipApp(
    retipRouter: retipRouter,
    retipTheme: retipTheme,
    themeCubit: themeCubit,
    retipL10n: retipL10n,
  );

  runApp(retipApp);
}
