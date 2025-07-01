import 'package:flutter/material.dart';
import 'package:retip/app/presentation/views/home/tabs/explore_tab.dart';
import 'package:retip/app/presentation/views/settings/settings_page.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/organisms/rp_app_bar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RpAppBar(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(RetipL10n.of(context).retip),
        actions: [
          RpIconButton(
            icon: Icons.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const ExploreTab(),
    );
  }
}
