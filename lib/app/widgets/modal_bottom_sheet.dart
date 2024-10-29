import 'package:flutter/material.dart';
import 'package:retip/app/widgets/option_list_tile.dart';
import 'package:retip/core/utils/sizer.dart';

class ModalBottomSheet extends StatelessWidget {
  final List<OptionListTile> options;

  const ModalBottomSheet({
    this.options = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: Sizer.x1),
      children: options,
    );
  }
}
