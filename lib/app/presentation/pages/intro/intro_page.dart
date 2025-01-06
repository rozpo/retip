import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/widgets/spacer.dart';
import 'package:retip/core/constants/routes_constants.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

import 'bloc/intro_bloc.dart';
import 'widgets/intro_allow_button.dart';
import 'widgets/intro_logo_widget.dart';
import 'widgets/intro_settings_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IntroBloc introBloc = IntroBloc();

    return BlocProvider(
      create: (context) => introBloc..add(IntroCheckPermissionsEvent()),
      child: BlocConsumer<IntroBloc, IntroState>(
        listener: (context, state) {
          if (state is IntroPermissionsGranted) {
            context.go(RoutesConstants.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(Sizer.x2),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      RetipL10n.of(context).retipMusicPlayer,
                      style: Theme.of(context).textTheme.displaySmall,
                      // textAlign: TextAlign.center,
                    ),
                    const VerticalSpacer(),
                    Text(
                      RetipL10n.of(context).retipDescription,
                      // textAlign: TextAlign.center,
                    ),
                    const VerticalSpacer(),
                    const VerticalSpacer(),
                    const Center(child: IntroLogoWidget()),
                    const VerticalSpacer(),
                    const VerticalSpacer(),
                    const Divider(),
                    Text(
                      RetipL10n.of(context).storagePermission,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacer(),
                    Text(
                      RetipL10n.of(context).grantPermission,
                      // textAlign: TextAlign.center,
                    ),
                    const VerticalSpacer(),
                    const VerticalSpacer(),
                    Row(
                      children: [
                        Expanded(
                          child: IntroSettingsButtonWidget(
                            onPressed: () => AppSettings.openAppSettings(),
                          ),
                        ),
                        const HorizontalSpacer(),
                        Expanded(
                          child: IntroAllowButtonWidget(
                            onPressed: () => introBloc.add(
                              IntroAskPermissionsEvent(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacer(),
                    const VerticalSpacer(),
                    const Divider(),
                    Text(
                      '"${RetipL10n.of(context).retipMotto}"',
                      // textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
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
