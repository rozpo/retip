import 'package:flutter/material.dart';

class ShortTextAtom extends StatelessWidget {
  final String data;

  const ShortTextAtom(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      data,
    );
  }
}
