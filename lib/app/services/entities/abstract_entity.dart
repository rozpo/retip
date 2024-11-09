import 'package:flutter/material.dart';

abstract class AbstractEntity {
  final int id;

  AbstractEntity({
    required this.id,
  });

  String toTypeString(BuildContext context) {
    throw UnimplementedError();
  }

  ListTile toListTile(BuildContext context, [String? query]) {
    throw UnimplementedError();
  }
}
