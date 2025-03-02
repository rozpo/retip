import 'package:flutter/material.dart';
import 'tabs/explore_tab.dart';
import '../../widgets/organisms/app_bar_widget.dart';
import '../../../../core/l10n/retip_l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(RetipL10n.of(context).retip),
      ),
      body: const ExploreTab(),
    );
  }
}
