import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

import 'bloc/intro_bloc.dart';
import 'widgets/intro_allow_button.dart';
import 'widgets/intro_logo_widget.dart';
import 'widgets/intro_settings_button.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final IntroBloc introBloc = IntroBloc();

    return BlocProvider(
      create: (context) => introBloc..add(IntroCheckPermissionsEvent()),
      child: BlocConsumer<IntroBloc, IntroState>(
        listener: (context, state) {
          if (state is IntroPermissionsGranted) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(Sizer.x2),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const IntroLogoWidget(),
                    const VerticalSpacer(),
                    Text(
                      RetipL10n.of(context).storagePermission,
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacer(),
                    Text(
                      RetipL10n.of(context).grantPermission,
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacer(),
                    IntroSettingsButtonWidget(
                      onPressed: () => AppSettings.openAppSettings(),
                    ),
                    const VerticalSpacer(),
                    IntroAllowButtonWidget(
                      onPressed: () => introBloc.add(
                        IntroAskPermissionsEvent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
