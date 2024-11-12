import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/views/dev/dev_view.dart';
import 'package:retip/app/views/home/pages/home/tabs/explore_tab.dart';
import 'package:retip/app/views/home/pages/home/tabs/favourites_tab.dart';
import 'package:retip/app/views/home/pages/home/tabs/playlists_tab.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: RpAppBar(
          leading: const Icon(Icons.queue_music_outlined),
          title: Text(RetipL10n.of(context).retip),
          actions: [
            if (kReleaseMode == false) ...[
              const HorizontalSpacer(),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DevView(),
                  ),
                ),
                icon: const Icon(Icons.developer_board),
              ),
            ]
          ],
          bottom: TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: RetipL10n.of(context).explore,
                icon: const Icon(Icons.explore),
              ),
              Tab(
                text: RetipL10n.of(context).favourites,
                icon: const Icon(Icons.favorite),
              ),
              Tab(
                text: RetipL10n.of(context).playlists,
                icon: const Icon(Icons.queue_music),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            ExploreTab(),
            FavouriteTab(),
            PlaylistsTab(),
          ],
        ),
      ),
    );
  }
}
