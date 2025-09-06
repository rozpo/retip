import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/avatars/avatar_plus_widget.dart';
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
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(l10n.settings),
            onTap: () {
              RetipRoute.settings.push(context);
            },
          ),
        ],
      ),
    );
  }
}
