import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/avatars/avatar_plus_widget.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_route.dart';

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
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('App info'),
            onTap: () {
              RetipRoute.appinfo.push(context);
            },
          ),
        ],
      ),
    );
  }
}
