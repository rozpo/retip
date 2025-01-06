import 'package:flutter/material.dart';
import 'package:retip/app/data/providers/retip_config.dart';

class DevSwitchListTile extends StatefulWidget {
  final RetipConfigBoolKey boolKey;

  const DevSwitchListTile({
    required this.boolKey,
    super.key,
  });

  @override
  State<DevSwitchListTile> createState() => _DevSwitchListTileState();
}

class _DevSwitchListTileState extends State<DevSwitchListTile> {
  @override
  Widget build(BuildContext context) {
    final key = widget.boolKey;

    return SwitchListTile(
      title: Text(key.name),
      value: RetipConfig.getBool(key),
      onChanged: (value) async {
        await RetipConfig.setBool(key, value);
        setState(() {});
      },
    );
  }
}
