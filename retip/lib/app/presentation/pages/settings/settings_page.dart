import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/retip_config.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/router/retip_route.dart';
import '../../widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showDevSection = !kReleaseMode;
  int _taps = 0;

  void _handleTaps() {
    if (++_taps >= 10) {
      setState(() {
        _showDevSection = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: !_showDevSection ? _handleTaps : null,
          child: Text(l10n.settings),
        ),
      ),
      body: ListView(
        children: [
          SectionListTile(l10n.apperance),
          ThemeModeSegmentedButtonWidget(),
          SectionListTile(l10n.info),
          ListTile(
            title: Text(l10n.appDetails),
            subtitle: Text('${l10n.version} v1.0.0+1'),
            leading: Icon(Icons.info),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => showAdaptiveAboutDialog(context: context),
          ),
          ListTile(
            title: Text(l10n.licenses),
            subtitle: Text(l10n.showThirdPartyLicenses),
            leading: Icon(Icons.description),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => showLicensePage(context: context),
          ),
          ListTile(
            title: Text(l10n.privacyPolicy),
            leading: Icon(Icons.privacy_tip),
            trailing: Icon(Icons.open_in_new),
            onTap: () => launchUrl(RetipConfig.privacyPolicyUrl),
          ),
          ListTile(
            title: Text(l10n.termsAndConditions),
            leading: Icon(Icons.gavel),
            trailing: Icon(Icons.open_in_new),
            onTap: () => launchUrl(RetipConfig.termsAndConditionsUrl),
          ),
          if (_showDevSection) ...[
            SectionListTile('Developer'),
            ListTile(
              title: Text('Console'),
              subtitle: Text('Open developer menu board'),
              leading: Icon(Icons.developer_board),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => RetipRoute.dev.push(context),
            ),
            ListTile(
              title: Text('Logger'),
              subtitle: Text('View application logs'),
              leading: Icon(Icons.monitor_heart),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => RetipRoute.logger.push(context),
            ),
          ],
        ],
      ),
    );
  }
}
