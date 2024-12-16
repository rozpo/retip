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
        actions: kReleaseMode == false
            ? [
                const HorizontalSpacer(),
                RpIconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DevView(),
                    ),
                  ),
                  icon: Icons.developer_board,
                ),
                const HorizontalSpacer(),
              ]
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        children: [
          RpDivider(
            text: l10n.info,
          ),
          SettingsTile(
            title: l10n.aboutApp,
            icon: Icons.info,
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
            onTap: () {
              final url = Uri.parse(
                'https://github.com/rozpo/retip/blob/main/docs/PRIVACY_POLICY.md',
              );
              launchUrl(url, mode: LaunchMode.externalApplication);
            },
          ),
          SettingsTile(
            title: l10n.licenses,
            icon: Icons.description,
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
        ],
      ),
    );
  }
}
