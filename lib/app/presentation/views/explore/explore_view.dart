import 'package:flutter/material.dart';

import '../../../../core/l10n/retip_l10n.dart';
import '../../widgets/widgets.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);
    return Scaffold(
      appBar: AppBarWidget(
        leading: const Icon(Icons.explore),
        title: SingleLineText(l10n.explore),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.explore, size: 64),
            Text(
              l10n.explore,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
