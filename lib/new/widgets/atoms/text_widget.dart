import 'package:flutter/material.dart';

class TextWidget extends Text {
  const TextWidget(
    super.data, {
    super.overflow = TextOverflow.ellipsis,
    super.maxLines,
    super.key,
  });

  factory TextWidget.short(
    String data, {
    Key? key,
  }) {
    return TextWidget(
      maxLines: 1,
      key: key,
      data,
    );
  }

  factory TextWidget.medium(
    String data, {
    Key? key,
  }) {
    return TextWidget(
      maxLines: 2,
      key: key,
      data,
    );
  }

  factory TextWidget.long(
    String data, {
    Key? key,
  }) {
    return TextWidget(
      key: key,
      data,
    );
  }
}
