import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retip/app/views/dev/dev_view.dart';
import 'package:retip/app/views/settings/widgets/settings_tile.dart';
import 'package:retip/app/widgets/buttons/rp_back_button.dart';
import 'package:retip/app/widgets/retip_icon.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/rp_divider.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = GetIt.I.get<PackageInfo>();
    final l10n = RetipL10n.of(context);
    final version = '${packageInfo.version}+${packageInfo.buildNumber}';

    return Scaffold(
      appBar: RpAppBar(
        leading: const RpBackButton(),
        title: RpText(RetipL10n.of(context).settings),
      ),
      body: ListView(
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
              separatorBuilder: (context, index) => const HorizontalSpacer(),
              padding: const EdgeInsets.all(Sizer.x1),
              itemCount: Colors.primaries.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final color = Colors.primaries[index];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizer.x0_5),
                    color: color,
                  ),
                  width: Sizer.x5,
                  height: Sizer.x5,
                );
              },
            ),
          ),
          SettingsTile(
            title: l10n.darkMode,
            icon: Icons.dark_mode,
            trailing: RpIconButton.filled(
              icon: Icons.check,
              onPressed: () {},
            ),
          ),
          SettingsTile(
            title: l10n.batterySaver,
            icon: Icons.battery_saver,
            trailing: RpIconButton.outlined(
              icon: Icons.close,
              onPressed: () {},
            ),
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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DevView(),
                ),
              ),
              trailing: const RpIconButton(icon: Icons.arrow_forward),
            ),
          ],
        ],
      ),
    );
  }
}
