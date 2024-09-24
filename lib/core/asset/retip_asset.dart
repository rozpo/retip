import 'package:flutter/foundation.dart';

mixin RetipAsset {
  // Directories paths
  static const String _assetsDir = 'assets';
  static const String _imagesDir = '$_assetsDir/icons';

  // Assets paths
  static const String logo =
      '$_imagesDir/retip_${kReleaseMode ? 'release' : 'debug'}.svg';
  static const String icon = '$_imagesDir/retip_monochrome.svg';
}
