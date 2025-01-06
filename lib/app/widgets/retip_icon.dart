import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retip/core/constants/assets_constants.dart';

class RetipIcon extends StatelessWidget {
  final Color? color;
  final Size? size;

  const RetipIcon({
    this.size,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? const Size.square(24);

    return SvgPicture.asset(
      AssetsConstants.retipMonochrome,
      width: size.width,
      height: size.height,
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
