import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Map<String, dynamic> toJson() {
    return {
      'a': a,
      'r': r,
      'g': g,
      'b': b,
    };
  }

  static Color fromJson(Map<String, dynamic> data) {
    final a = double.parse(data['a']);
    final r = double.parse(data['r']);
    final g = double.parse(data['g']);
    final b = double.parse(data['b']);

    return Color.from(
      alpha: a,
      red: r,
      green: g,
      blue: b,
    );
  }
}
