import 'package:flutter/material.dart';

import 'app/data/providers/app_settings_provider.dart';
import 'app/data/providers/objectbox_provider.dart';
import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/config_repository_i.dart';
import 'app/data/repositories/library_repository_i.dart';
import 'app/data/repositories/permission_repository_i.dart';
import 'app/data/repositories/settings_repository_i.dart';
import 'app/presentation/cubits/library/library_cubit.dart';
import 'app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'app/presentation/cubits/permission/permission_cubit.dart';
import 'app/retip_app.dart';
import 'core/l10n/retip_l10n.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers
  final sharedPreferencesProvider = await SharedPreferencesProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();
  final appSettingsProvider = await AppSettingsProvider.init();
  final objectboxProvider = await ObjectboxProvider.init();

  // Repositories
  final configRepository = ConfigRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  final permissionRepository = PermissionRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
  );

  final settingsRepository = SettingsRepositoryI(
    appSettingsProvider: appSettingsProvider,
  );

  final libraryRepository = LibraryRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
    objectboxProvider: objectboxProvider,
  );

  // Cubits
  final onboardingCubit = OnboardingCubit(
    configRepository: configRepository,
  );

  final permissionCubit = PermissionCubit(
    permissionRepository: permissionRepository,
    settingsRepository: settingsRepository,
  );

  final libraryCubit = LibraryCubit(
    libraryRepository: libraryRepository,
  );

  // Core
  final router = RetipRouter();
  final theme = RetipTheme();
  final l10n = RetipL10n();

  final app = RetipApp(
    permissionRepository: permissionRepository,
    settingsRepository: settingsRepository,
    configRepository: configRepository,
    onboardingCubit: onboardingCubit,
    permissionCubit: permissionCubit,
    libraryCubit: libraryCubit,
    router: router,
    theme: theme,
    l10n: l10n,
  );

  runApp(app);
}
