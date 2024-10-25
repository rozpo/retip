import 'package:flutter/material.dart';

abstract class AbstractEntity {
  ListTile toListTile(BuildContext context) {
    throw UnimplementedError();
  }
}
