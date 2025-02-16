import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/l10n/retip_l10n.dart';
import '../core/router/retip_router.dart';
import '../core/theme/retip_theme.dart';
import 'presentation/cubits/permission/permission_cubit.dart';
import 'presentation/cubits/theme/theme_cubit.dart';

class RetipApp extends StatelessWidget {
  final PermissionCubit _permissionCubit;
  final RetipRouter _retipRouter;
  final RetipTheme _retipTheme;
  final ThemeCubit _themeCubit;
  final RetipL10n _retipL10n;

  const RetipApp({
    required PermissionCubit permissionCubit,
    required RetipRouter retipRouter,
    required RetipTheme retipTheme,
    required ThemeCubit themeCubit,
    required RetipL10n retipL10n,
    super.key,
  })  : _permissionCubit = permissionCubit,
        _retipRouter = retipRouter,
        _retipTheme = retipTheme,
        _themeCubit = themeCubit,
        _retipL10n = retipL10n;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _retipRouter),
        RepositoryProvider(create: (context) => _retipL10n),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _permissionCubit),
          BlocProvider(create: (context) => _themeCubit),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return MaterialApp.router(
              localizationsDelegates: _retipL10n.localizationsDelegates,
              highContrastDarkTheme: _retipTheme.highContrastDark,
              highContrastTheme: _retipTheme.highContrastLight,
              supportedLocales: _retipL10n.supportedLocales,
              themeMode: ThemeMode.system,
              darkTheme: _retipTheme.dark(state.primaryColor),
              theme: _retipTheme.light(state.primaryColor),
              routerConfig: _retipRouter,
            );
          },
        ),
      ),
    );
  }
}
