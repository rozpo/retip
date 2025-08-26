import 'package:flutter/material.dart';

class CompactTemplateLayout extends StatelessWidget {
  final Widget body;

  const CompactTemplateLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
