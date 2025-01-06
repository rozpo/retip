import 'package:flutter/material.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';

abstract class AbstractEntity {
  final int id;

  AbstractEntity({
    required this.id,
  });

  String toTypeString(BuildContext context) {
    throw UnimplementedError();
  }

  RpListTile toListTile(BuildContext context, [String? query]) {
    throw UnimplementedError();
  }
}
