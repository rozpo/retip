import 'package:flutter/material.dart';

import '../atoms/content_padding.dart';

class PlaylistTemplate extends StatelessWidget {
  final String title;

  const PlaylistTemplate({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(title),
          bottom: PreferredSize(
              preferredSize: MediaQuery.of(context).size * 0.1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 100,
                          height: double.infinity,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const ContentPadding(),
                  Container(
                    height: 1,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                ],
              )),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Track $index'),
                    subtitle: Text('Artist $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
