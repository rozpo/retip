import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retip/app/views/dev/dev_view.dart';
import 'package:retip/app/widgets/buttons/rp_back_button.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/rp_divider.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = GetIt.I.get<PackageInfo>();
    final l10n = RetipL10n.of(context);

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
          RpListTile(
            leading: const Icon(Icons.info),
            title: RpText(
                '${l10n.version} ${packageInfo.version}+${packageInfo.buildNumber}'),
          ),
        ],
      ),
    );
  }
}
