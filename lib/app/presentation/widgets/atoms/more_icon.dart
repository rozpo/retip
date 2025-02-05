import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_image.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_divider.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/utils/sizer.dart';

class MoreIcon extends StatelessWidget {
  final Uint8List? image;
  final String title;
  final String? subtitle;

  final List<Widget> tiles;

  final bool isVertical;

  const MoreIcon.horizontal({
    required this.title,
    this.tiles = const [],
    this.subtitle,
    this.image,
    super.key,
  }) : isVertical = false;

  const MoreIcon.vertical({
    required this.title,
    this.tiles = const [],
    this.subtitle,
    this.image,
    super.key,
  }) : isVertical = true;

  @override
  Widget build(BuildContext context) {
    return RpIconButton(
      icon: isVertical ? Icons.more_vert : Icons.more_horiz,
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          context: RetipRouter.rootNavKey.currentContext ?? context,
          builder: (context) {
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(top: Sizer.x1),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: SingleLineText(title),
                    subtitle:
                        subtitle != null ? SingleLineText(subtitle!) : null,
                    leading: image != null
                        ? RpIconImage(bytes: image!)
                        : const RpIcon(icon: Icons.music_note),
                    trailing: RpIconButton(
                      icon: Icons.close,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const RpDivider(),
                  ...tiles,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
