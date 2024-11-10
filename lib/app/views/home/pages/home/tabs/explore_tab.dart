import 'package:flutter/material.dart';
import 'package:retip/app/widgets/retip_icon.dart';
import 'package:retip/core/utils/sizer.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RetipIcon(
        size: Size.square(Sizer.x8 * 2),
      ),
    );
  }
}
