import 'package:flutter/material.dart';

class LeadingListTileCardWidget extends StatelessWidget {
  final IconData icon;

  const LeadingListTileCardWidget(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: SizedBox.square(dimension: 40, child: Icon(icon)));
  }
}
