import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retip/app/data/providers/retip_config.dart';
import 'package:retip/app/presentation/pages/dev/widgets/dev_switch_list_tile.dart';
import 'package:retip/app/presentation/widgets/buttons/rp_back_button.dart';
import 'package:retip/app/presentation/widgets/rp_app_bar.dart';
import 'package:retip/app/presentation/widgets/rp_divider.dart';
import 'package:retip/app/presentation/widgets/rp_list_tile.dart';
import 'package:retip/app/presentation/widgets/rp_text.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    final packageInfo = GetIt.I.get<PackageInfo>();

    return Scaffold(
      appBar: RpAppBar(
        leading: const RpBackButton(),
        title: RpText(RetipL10n.of(context).developer),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        children: [
          RpDivider(
            text: RetipL10n.of(context).developer,
          ),
          const DevSwitchListTile(
            boolKey: RetipConfigBoolKey.debugShowCheckedModeBanner,
          ),
          const DevSwitchListTile(
            boolKey: RetipConfigBoolKey.debugRepaintRainbowEnabled,
          ),
          const DevSwitchListTile(
            boolKey: RetipConfigBoolKey.debugInvertOversizedImages,
          ),
          const DevSwitchListTile(
            boolKey: RetipConfigBoolKey.showPerformanceOverlay,
          ),
          RpDivider(
            text: RetipL10n.of(context).info,
          ),
          RpListTile(
            leading: const Icon(Icons.shop),
            title: RpText('${packageInfo.installerStore}'),
          ),
          RpListTile(
            leading: const Icon(Icons.key),
            title: Text(packageInfo.buildSignature),
          ),
        ],
      ),
    );
  }
}
