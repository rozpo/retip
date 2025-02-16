import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/sizer.dart';

class RpIconImage extends StatelessWidget {
  final Uint8List bytes;

  const RpIconImage({
    required this.bytes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizer.x0_5),
      child: Image.memory(
        width: Sizer.x5,
        height: Sizer.x5,
        bytes,
      ),
    );
  }
}
