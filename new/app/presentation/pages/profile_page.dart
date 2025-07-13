import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('History'),
            onTap: () => context.push(RetipRoutes.history),
          ),
          ListTile(
            title: const Text('Storage'),
            onTap: () => context.push(RetipRoutes.storage),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () => context.push(RetipRoutes.settings),
          ),
          const Divider(),
          ListTile(
            title: const Text('App'),
            onTap: () => showAboutDialog(context: context),
          ),
          ListTile(
            title: const Text('Licenses'),
            onTap: () => showLicensePage(context: context),
          ),
          const Divider(),
          ListTile(
            title: const Text('Developer'),
            onTap: () => context.push(RetipRoutes.developer),
          ),
          ListTile(
            title: const Text('Logger'),
            onTap: () => context.push(RetipRoutes.logger),
          ),
        ],
      ),
    );
  }
}
