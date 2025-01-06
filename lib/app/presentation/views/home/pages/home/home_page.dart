import 'package:flutter/material.dart';
import 'package:retip/app/presentation/views/home/pages/home/tabs/explore_tab.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RetipPage extends StatelessWidget {
  const RetipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RpAppBar(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(RetipL10n.of(context).retip),
      ),
      body: const ExploreTab(),
    );
  }
}
