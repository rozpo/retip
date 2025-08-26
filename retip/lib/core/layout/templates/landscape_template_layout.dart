import 'package:flutter/material.dart';
import 'package:retip/app/presentation/pages/pages.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class LandscapeTemplateLayout extends StatelessWidget {
  final Widget body;
  const LandscapeTemplateLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          RailNavigationWidget(),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: body),
          Expanded(child: PlayerPage()),
        ],
      ),
    );
  }
}
