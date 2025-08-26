import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';

class PortraitTemplateLayout extends StatelessWidget {
  final Widget body;

  const PortraitTemplateLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [PlayerWidget(), BottomNavigationWidget()],
      ),
    );
  }
}
