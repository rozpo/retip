import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retip/app/presentation/views/settings/widgets/settings_tile.dart';
import 'package:retip/app/presentation/widgets/atoms/retip_icon.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/atoms/spacer.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_divider.dart';
import 'package:retip/app/presentation/widgets/organisms/app_bar_widget.dart';
import 'package:retip/core/constants/layout_constants.dart';
import 'package:retip/core/constants/routes_constants.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = GetIt.I.get<PackageInfo>();
    final l10n = RetipL10n.of(context);
    final version = '${packageInfo.version}+${packageInfo.buildNumber}';

    return Scaffold(
      appBar: AppBarWidget(
        leading: const Icon(Icons.settings),
        title: SingleLineText(RetipL10n.of(context).settings),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
            physics: const BouncingScrollPhysics(),
            children: [
              RpDivider(
                text: l10n.appearance,
              ),
              SizedBox(
                height: Sizer.x5 + Sizer.x2,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const HorizontalSpacer(),
                  padding: const EdgeInsets.all(Sizer.x1),
                  itemCount: Colors.primaries.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final color = Colors.primaries[index];
                    final isToggled = color == state.themeColor;

                    return GestureDetector(
                      onTap: () => cubit.setColorTheme(color),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizer.x0_5),
                          color: color,
                        ),
                        width: Sizer.x5,
                        height: Sizer.x5,
                        child: isToggled
                            ? Icon(
                                color: Theme.of(context).colorScheme.onPrimary,
                                Icons.check,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
              SettingsTile(
                onTap: cubit.toggleDarkMode,
                title: l10n.themeMode,
                subtitle: state.darkMode ? l10n.dark : l10n.light,
                icon: state.darkMode ? Icons.dark_mode : Icons.light_mode,
                trailing: state.darkMode
                    ? RpIconButton.filled(
                        icon: Icons.toggle_on,
                        onPressed: cubit.toggleDarkMode,
                      )
                    : RpIconButton(
                        icon: Icons.toggle_off_outlined,
                        onPressed: cubit.toggleDarkMode,
                      ),
              ),
              SettingsTile(
                onTap: cubit.toggleBatterySaver,
                title: l10n.batterySaver,
                subtitle: state.batterySaver
                    ? l10n.reduceApplicationAnimations
                    : l10n.off,
                icon: state.batterySaver
                    ? Icons.battery_saver
                    : Icons.battery_std,
                trailing: state.batterySaver
                    ? RpIconButton.filled(
                        icon: Icons.toggle_on,
                        onPressed: cubit.toggleBatterySaver,
                      )
                    : RpIconButton(
                        icon: Icons.toggle_off_outlined,
                        onPressed: cubit.toggleBatterySaver,
                      ),
              ),
              RpDivider(
                text: l10n.playback,
              ),
              SettingsTile(
                onTap: cubit.toggleKeepPlayback,
                title: l10n.keepPlayback,
                subtitle: l10n.resumePlaybackOn,
                icon: state.keepPlayback ? Icons.music_note : Icons.music_off,
                trailing: state.keepPlayback
                    ? RpIconButton.filled(
                        icon: Icons.toggle_on,
                        onPressed: cubit.toggleKeepPlayback,
                      )
                    : RpIconButton(
                        icon: Icons.toggle_off_outlined,
                        onPressed: cubit.toggleKeepPlayback,
                      ),
              ),
              SettingsTile(
                onTap: state.keepPlayback ? cubit.toggleAutoplay : null,
                subtitle: l10n.playOnAppStart,
                title: l10n.autoplay,
                icon: state.autoplay
                    ? Icons.play_circle
                    : Icons.play_circle_outline,
                trailing: state.autoplay && state.keepPlayback
                    ? RpIconButton.filled(
                        icon: Icons.toggle_on,
                        onPressed:
                            state.keepPlayback ? cubit.toggleAutoplay : null,
                      )
                    : RpIconButton(
                        icon: Icons.toggle_off_outlined,
                        onPressed:
                            state.keepPlayback ? cubit.toggleAutoplay : null,
                      ),
              ),
              // SettingsTile(
              //   title: l10n.crossfade,
              //   icon: Icons.graphic_eq,
              //   trailing: RpIconButton(
              //     icon: Icons.toggle_off_outlined,
              //     onPressed: () {},
              //   ),
              // ),
              // SettingsTile(
              //   title: l10n.equalizer,
              //   icon: Icons.equalizer,
              //   trailing: const RpIconButton(icon: Icons.arrow_forward),
              // ),
              RpDivider(text: l10n.library),
              ListTile(
                leading: const RpIcon(icon: Icons.grid_on),
                title: Text(l10n.gridView),
                subtitle: Text(l10n.columnsCount(state.gridViewColumns)),
              ),
              Slider(
                value: state.gridViewColumns.toDouble(),
                min: LayoutConstants.minGridViewColumns.toDouble(),
                max: LayoutConstants.maxGridViewColumns.toDouble(),
                divisions: (LayoutConstants.maxGridViewColumns.toDouble() /
                        LayoutConstants.minGridViewColumns.toDouble())
                    .toInt(),
                onChanged: (value) {
                  cubit.setGridViewColumns(value.toInt());
                },
              ),
              RpDivider(
                text: l10n.info,
              ),
              SettingsTile(
                title: l10n.aboutApp,
                icon: Icons.info,
                trailing: const RpIconButton(icon: Icons.arrow_forward),
                onTap: () {
                  showAboutDialog(
                    applicationName: l10n.retip,
                    applicationLegalese: l10n.legalese,
                    applicationIcon: const RetipIcon(size: Size.square(64)),
                    applicationVersion: 'v$version',
                    context: context,
                  );
                },
              ),
              SettingsTile(
                title: l10n.checkForUpdate,
                icon: Icons.update,
                trailing: const RpIconButton(icon: Icons.shop),
                onTap: () {
                  final url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=dev.rozpo.retip',
                  );
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
              SettingsTile(
                title: l10n.privacyPolicy,
                icon: Icons.privacy_tip,
                trailing: const RpIconButton(icon: Icons.public),
                onTap: () {
                  final url = Uri.parse(
                    'https://github.com/rozpo/retip/blob/main/docs/PRIVACY_POLICY.md',
                  );
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
              SettingsTile(
                title: l10n.termsAndConditions,
                icon: Icons.gavel,
                trailing: const RpIconButton(icon: Icons.public),
                onTap: () {
                  final url = Uri.parse(
                      'https://github.com/rozpo/retip/blob/main/docs/TERMS_AND_CONDITIONS.md');
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
              SettingsTile(
                title: l10n.licenses,
                icon: Icons.description,
                trailing: const RpIconButton(icon: Icons.arrow_forward),
                onTap: () {
                  showLicensePage(
                    applicationLegalese: l10n.legalese,
                    applicationName: l10n.retip,
                    applicationIcon: const RetipIcon(size: Size.square(64)),
                    applicationVersion: 'v$version',
                    context: context,
                  );
                },
              ),
              if (kReleaseMode == false) ...[
                RpDivider(
                  text: l10n.developer,
                ),
                SettingsTile(
                  title: l10n.developerMenu,
                  icon: Icons.developer_board,
                  onTap: () => context.go(RoutesConstants.dev),
                  trailing: const RpIconButton(icon: Icons.arrow_forward),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
