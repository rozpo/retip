import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retip/core/asset/retip_asset.dart';

class IntroLogoWidget extends StatelessWidget {
  const IntroLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: SvgPicture.asset(
        RetipAsset.logo,
        width: 200,
        height: 200,
      ),
    );
  }
}
