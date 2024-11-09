import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/widgets/option_list_tile.dart';
import 'package:retip/core/utils/sizer.dart';

class ModalBottomSheet extends StatelessWidget {
  final String? header;
  final Uint8List? artwork;
  final List<OptionListTile> options;

  const ModalBottomSheet({
    this.artwork,
    this.header,
    this.options = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: Sizer.x1),
      children: [
        if (header != null)
          OptionListTile(
            artwork: artwork,
            text: header!,
            icon: Icons.album,
          ),
        const Divider(),
        ...options,
      ],
    );
  }
}
