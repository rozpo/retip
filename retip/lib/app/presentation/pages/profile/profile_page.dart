import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/avatars/avatar_plus_widget.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_route.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/retip_config.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          AvatarPlusWidget(size: MediaQuery.of(context).size.width / 6),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Hello Peter!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SectionListTile('Personal'),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            subtitle: Text('My playing history'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Storage'),
            subtitle: Text('Check for app storage usage'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text('Backup'),
            subtitle: Text('Import or export a backup files'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(l10n.settings),
            subtitle: Text('Manage app settings'),
            onTap: () {
              RetipRoute.settings.push(context);
            },
          ),
          SectionListTile(l10n.infoAboutApp),
          ListTile(
            title: Text(l10n.appDetails),
            subtitle: Text('${l10n.version} v1.0.0+1'),
            leading: Icon(Icons.info),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => showAboutDialog(
              applicationIcon: FlutterLogo(size: 64),
              applicationLegalese: l10n.appLegalese,
              applicationName: l10n.appName,
              applicationVersion: 'v1.0.0+1',
              context: context,
            ),
          ),
          ListTile(
            title: Text(l10n.licenses),
            subtitle: Text(l10n.showThirdPartyLicenses),
            leading: Icon(Icons.description),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => showLicensePage(
              applicationIcon: FlutterLogo(size: 64),
              applicationLegalese: l10n.appLegalese,
              applicationName: l10n.appName,
              applicationVersion: 'v1.0.0+1',
              context: context,
            ),
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
        ],
      ),
    );
  }
}
