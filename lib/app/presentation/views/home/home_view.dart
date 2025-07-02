import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/views/home/tabs/explore_tab.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/organisms/rp_app_bar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_route.dart';

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
            onPressed: () => context.push(RetipRoute.settings),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const ExploreTab(),
    );
  }
}
