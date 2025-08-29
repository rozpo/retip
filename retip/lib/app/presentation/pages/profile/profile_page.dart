import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Name'),
            subtitle: Text('user@example.com'),
          ),
          ListTile(
            title: Text('App info'),
            onTap: () {
              showAboutDialog(
                applicationName: 'Retip',
                applicationVersion: 'v1.0.0+1',
                applicationIcon: FlutterLogo(size: 64),
                applicationLegalese: '© 2024 Piotr Rozponczyk',
                barrierDismissible: true,
                context: context,
                children: [
                  Divider(),
                  Text('Retip is a music player built using Flutter'),
                ],
              );
            },
          ),
          ListTile(
            title: Text('Licenses'),
            onTap: () {
              showLicensePage(
                applicationName: 'Retip',
                applicationVersion: 'v1.0.0+1',
                applicationIcon: FlutterLogo(size: 64),
                applicationLegalese: '© 2024 Piotr Rozponczyk',
                context: context,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              context.push('/settings');
            },
          ),
          if (kReleaseMode == false) ...[
            Divider(),
            ListTile(
              leading: Icon(Icons.developer_board),
              title: Text('Developer'),
              onTap: () {
                context.push('/dev');
              },
            ),
            ListTile(
              leading: Icon(Icons.monitor_heart),
              title: Text('Logs'),
              onTap: () {
                context.push('/logger');
              },
            ),
          ],
        ],
      ),
    );
  }
}
