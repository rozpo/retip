import 'package:flutter/material.dart';

class LandscapeTemplateLayout extends StatelessWidget {
  final Widget body;
  const LandscapeTemplateLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
