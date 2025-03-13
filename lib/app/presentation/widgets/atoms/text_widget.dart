import 'package:flutter/material.dart';

class TextWidget extends Text {
  const TextWidget.short(
    super.data, {
    super.key,
  }) : super(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        );

  const TextWidget.medium(
    super.data, {
    super.key,
  }) : super(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        );

  const TextWidget.long(
    super.data, {
    super.key,
  }) : super(
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        );
}
