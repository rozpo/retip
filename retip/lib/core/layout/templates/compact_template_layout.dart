import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class CompactTemplateLayout extends StatelessWidget {
  final Widget body;

  const CompactTemplateLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavigationWidget(),
      appBar: AppBar(title: Text('Compact Layout')),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: AlwaysStoppedAnimation(0.0),
        ),
      ),
    );
  }
}
