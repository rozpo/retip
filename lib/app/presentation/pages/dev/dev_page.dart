import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retip/app/presentation/pages/dev/widgets/dev_switch_list_tile.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_back_button.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_divider.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_list_tile.dart';
import 'package:retip/app/presentation/widgets/organisms/app_bar_widget.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

import '../../../domain/repositories/debug_repository.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    final packageInfo = GetIt.I.get<PackageInfo>();
    final debugRepository = context.read<DebugRepository>();

    return Scaffold(
      appBar: AppBarWidget(
        leading: const RpBackButton(),
        title: SingleLineText(RetipL10n.of(context).developer),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
        physics: const BouncingScrollPhysics(),
        children: [
          RpDivider(
            text: RetipL10n.of(context).developer,
          ),
          DevSwitchListTile(
            name: 'debugShowCheckedModeBanner',
            value: debugRepository.getDebugShowCheckedModeBanner(),
            onChanged: (value) {
              debugRepository.setDebugShowCheckedModeBanner(value);
            },
          ),
          DevSwitchListTile(
            name: 'debugRepaintRainbowEnabled',
            value: debugRepository.getDebugRepaintRainbowEnabled(),
            onChanged: (value) {
              debugRepository.setDebugRepaintRainbowEnabled(value);
            },
          ),
          DevSwitchListTile(
            name: 'debugInvertOversizedImages',
            value: debugRepository.getDebugInvertOversizedImages(),
            onChanged: (value) {
              debugRepository.setDebugInvertOversizedImages(value);
            },
          ),
          DevSwitchListTile(
            name: 'showPerformanceOverlay',
            value: debugRepository.getShowPerformanceOverlay(),
            onChanged: (value) {
              debugRepository.setShowPerformanceOverlay(value);
            },
          ),
          RpDivider(
            text: RetipL10n.of(context).info,
          ),
          RpListTile(
            leading: const Icon(Icons.shop),
            title: SingleLineText('${packageInfo.installerStore}'),
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
