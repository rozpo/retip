import 'package:flutter/material.dart';

class PortraitTemplateLayout extends StatelessWidget {
  final Widget body;

  const PortraitTemplateLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
