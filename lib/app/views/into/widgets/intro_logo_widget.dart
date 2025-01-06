import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retip/core/constants/assets_constants.dart';

class IntroLogoWidget extends StatelessWidget {
  const IntroLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: SvgPicture.asset(
        kReleaseMode
            ? AssetsConstants.retipRelease
            : kProfileMode
                ? AssetsConstants.retipProfile
                : AssetsConstants.retipDebug,
        width: 200,
        height: 200,
      ),
    );
  }
}
