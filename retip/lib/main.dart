import 'package:flutter/material.dart';
import 'package:retip/app/data/repositories/onboarding_repository_i.dart';

import 'app/data/providers/on_audio_query_provider.dart';
import 'app/data/providers/shared_preferences_provider.dart';
import 'app/data/repositories/permissions_repository_i.dart';
import 'app/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'app/presentation/blocs/permissions/permissions_bloc.dart';
import 'app/retip_app.dart';
import 'core/logger/retip_logger.dart';
import 'core/router/retip_router.dart';
import 'core/theme/retip_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RetipLogger.init();

  final theme = RetipTheme();

  final sharedPreferencesProvider = await SharedPreferencesProvider.init();
  final onAudioQueryProvider = await OnAudioQueryProvider.init();

  final onboardingRepository = OnboardingRepositoryI(
    sharedPreferencesProvider: sharedPreferencesProvider,
  );

  final permissionsRepository = PermissionsRepositoryI(
    onAudioQueryProvider: onAudioQueryProvider,
  );

  final onboardingBloc = OnboardingBloc(
    onboardingRepository: onboardingRepository,
  );

  final permissionsBloc = PermissionsBloc(
    permissionsRepository: permissionsRepository,
  );

  final router = RetipRouter(onboardingBloc, permissionsBloc);

  final app = RetipApp(
    permissionsBloc: permissionsBloc,
    onboardingBloc: onboardingBloc,
    router: router,
    theme: theme,
  );

  RetipLogger.info('App started');

  runApp(app);
}
