import 'package:flutter/material.dart';
import 'package:retip/app/views/home/pages/home/tabs/explore_tab.dart';
import 'package:retip/app/views/settings/settings_page.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RpAppBar(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(RetipL10n.of(context).retip),
        actions: [
          const HorizontalSpacer(),
          RpIconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            ),
            icon: Icons.settings,
          ),
          const HorizontalSpacer(),
        ],
      ),
      body: const ExploreTab(),
    );
  }
}
