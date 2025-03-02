import 'package:flutter/material.dart';

class TextAtom extends Text {
  const TextAtom(
    super.data, {
    super.overflow = TextOverflow.ellipsis,
    super.maxLines,
    super.key,
  });

  factory TextAtom.short(
    String data, {
    Key? key,
  }) {
    return TextAtom(
      maxLines: 1,
      key: key,
      data,
    );
  }

  factory TextAtom.medium(
    String data, {
    Key? key,
  }) {
    return TextAtom(
      maxLines: 2,
      key: key,
      data,
    );
  }

  factory TextAtom.long(
    String data, {
    Key? key,
  }) {
    return TextAtom(
      key: key,
      data,
    );
  }
}
