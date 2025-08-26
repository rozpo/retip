import 'package:flutter/material.dart';
import 'package:retip/core/layout/templates/compact_template_layout.dart';

import 'templates/landscape_template_layout.dart';
import 'templates/portrait_template_layout.dart';

class RetipLayout extends StatelessWidget {

  final Widget body;

  const RetipLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return aspectRatio > 0.75
              ? CompactTemplateLayout(body: body)
              : PortraitTemplateLayout(body: body);
        } else {
          return aspectRatio < 1.25
              ? CompactTemplateLayout(body: body)
              : LandscapeTemplateLayout(body: body);
        }
      },
    );
  }
}
