import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.history_outlined),
            title: Text('History'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: () => context.push(RetipRoutes.settings),
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.update_outlined),
            title: Text('Check for update'),
            trailing: Icon(Icons.shop_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => showAboutDialog(context: context),
            leading: Icon(Icons.info_outlined),
            title: Text('About application'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: () => showLicensePage(context: context),
            leading: Icon(Icons.description_outlined),
            title: Text('Licenses'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy policy'),
            trailing: Icon(Icons.public_outlined),
          ),
          ListTile(
            leading: Icon(Icons.gavel_outlined),
            title: Text('Terms and conditions'),
            trailing: Icon(Icons.public_outlined),
          ),
          if (kReleaseMode == false) ...[
            Divider(),
            ListTile(
              onTap: () => context.push(RetipRoutes.dev),
              leading: Icon(Icons.developer_board_rounded),
              title: Text('Developer'),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              leading: Icon(Icons.monitor_heart_outlined),
              title: Text('Logger'),

              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ],
      ),
    );
  }
}
