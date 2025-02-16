import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/data/providers/on_audio_query_provider.dart';
import '../app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/permission_repository_i.dart';
import 'app/presentation/cubits/permission/permission_cubit.dart';
import 'app/presentation/cubits/theme/theme_cubit.dart';
import 'app/retip_app.dart';
import 'core/l10n/retip_l10n.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';
import 'core/theme/src/retip_button_theme.dart';

void main() async {
  // Init
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  // Core
  final retipRouter = RetipRouter();
  final retipL10n = RetipL10n();

  final retipTheme = RetipTheme(
    retipButtonTheme: RetipButtonTheme(),
  );

  // Providers
  final sharedPreferencesProvicer = SharedPreferencesProvider(
    sharedPreferences: sharedPreferences,
  );
  final onAudioQueryProvider = OnAudioQueryProvider();

  // Repositories
  final permissionRepository = PermissionRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvicer,
    onAudioQueryProvider: onAudioQueryProvider,
  );

  // Cubits
  final permissionCubit = PermissionCubit(
    permissionRepository: permissionRepository,
  );

  final themeCubit = ThemeCubit();

  final retipApp = RetipApp(
    permissionCubit: permissionCubit,
    retipRouter: retipRouter,
    retipTheme: retipTheme,
    themeCubit: themeCubit,
    retipL10n: retipL10n,
  );

  runApp(retipApp);
}
