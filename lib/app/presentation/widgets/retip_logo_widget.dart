import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/retip_assets.dart';

class RetipLogoWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const RetipLogoWidget({
    this.height,
    this.width,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      RetipAssets.logoMonochrome,
      height: height,
      width: width,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
