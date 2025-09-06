import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';

class AvatarPlusWidget extends StatelessWidget {
  final double? size;

  const AvatarPlusWidget({this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'avatar',
      child: CircleAvatar(
        radius: size,
        child: AvatarPlus('c2c1d593-c480-4f6e-bf33-af54305d02b6'),
      ),
    );
  }
}
