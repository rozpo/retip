import 'package:flutter/material.dart';

class SortSheetWidget extends StatelessWidget {
  const SortSheetWidget({super.key});

  Future<void> show(BuildContext context) async {
    return showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.9,
      isScrollControlled: true,
      shape: const ContinuousRectangleBorder(),
      builder: (context) => this,
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(
          title: Text('Tracks sorting'),
          subtitle: Text('...'),
          leading: Icon(Icons.sort),
          trailing: Icon(Icons.close),
        ),
        const Divider(),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Ascending'),
              onTap: () {},
              leading: const Icon(Icons.keyboard_arrow_up),
              trailing: const Icon(Icons.check),
            ),
            ListTile(
              title: const Text('Descending'),
              onTap: () {},
              leading: const Icon(Icons.keyboard_arrow_down),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              trailing: const Icon(Icons.check),
              title: const Text('Sort by name'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.album),
              title: const Text('Sort by album'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Sort by artist'),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
