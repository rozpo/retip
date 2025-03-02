import 'package:flutter/material.dart';

class TabViewTemplate extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;

  const TabViewTemplate({
    required this.tabs,
    required this.children,
    super.key,
  }) : assert(tabs.length == children.length);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: children,
        ),
      ),
    );
  }
}
