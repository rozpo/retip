import 'package:flutter/material.dart';

enum _Type {
  display,
  headline,
  title,
  body,
  label,
}

class RpText extends StatelessWidget {
  final String data;

  const RpText.display(
    this.data, {
    super.key,
  }) : _type = _Type.display;

  const RpText.headline(
    this.data, {
    super.key,
  }) : _type = _Type.headline;

  const RpText.title(
    this.data, {
    super.key,
  }) : _type = _Type.title;

  const RpText.body(
    this.data, {
    super.key,
  }) : _type = _Type.body;

  const RpText.label(
    this.data, {
    super.key,
  }) : _type = _Type.label;

  final _Type _type;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style;

    switch (_type) {
      case _Type.display:
        style = Theme.of(context).textTheme.displayMedium;
        break;
      case _Type.headline:
        style = Theme.of(context).textTheme.headlineMedium;
        break;
      case _Type.title:
        style = Theme.of(context).textTheme.titleMedium;
        break;
      case _Type.body:
        style = Theme.of(context).textTheme.bodyMedium;
        break;
      case _Type.label:
        style = Theme.of(context).textTheme.labelMedium;
        break;
    }

    return Text(
      style: style,
      data,
    );
  }
}
