import 'package:flutter/material.dart';

abstract class AbstractEntity {
  String toTypeString(BuildContext context) {
    throw UnimplementedError();
  }

  ListTile toListTile(BuildContext context) {
    throw UnimplementedError();
  }
}