import 'package:flutter/material.dart';

class DevSwitchListTile extends StatefulWidget {
  final void Function(bool value) onChanged;
  final String name;
  final bool value;

  const DevSwitchListTile({
    required this.onChanged,
    required this.name,
    required this.value,
    super.key,
  });

  @override
  State<DevSwitchListTile> createState() => _DevSwitchListTileState();
}

class _DevSwitchListTileState extends State<DevSwitchListTile> {
  bool value = false;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.name),
      value: value,
      onChanged: (val) {
        widget.onChanged(val);
        value = val;
        setState(() {});
      },
    );
  }
}
