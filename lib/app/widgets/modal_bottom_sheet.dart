import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/widgets/option_list_tile.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/core/utils/sizer.dart';

class ModalBottomSheet extends StatelessWidget {
  final String? header;
  final String? subheader;
  final Uint8List? artwork;
  final List<OptionListTile> options;

  const ModalBottomSheet({
    this.artwork,
    this.header,
    this.subheader,
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
            title: header!,
            icon: Icons.album,
            subtitle: subheader,
            trailing: RpIconButton(
              icon: Icons.close,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        const Divider(
          indent: Sizer.x1,
          endIndent: Sizer.x1,
        ),
        ...options,
      ],
    );
  }
}
