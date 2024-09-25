import 'package:flutter/material.dart';
import 'package:retip/app/views/dev/widgets/dev_switch_list_tile.dart';
import 'package:retip/core/config/retip_config.dart';

class DevMenu extends StatefulWidget {
  const DevMenu({super.key});

  @override
  State<DevMenu> createState() => _DevMenuState();
}

class _DevMenuState extends State<DevMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevMenu'),
      ),
      body: ListView(
        children: const [
          DevSwitchListTile(
            boolKey: RetipConfigBoolKey.debugShowCheckedModeBanner,
          ),
          DevSwitchListTile(
            boolKey: RetipConfigBoolKey.debugRepaintRainbowEnabled,
          ),
          DevSwitchListTile(
            boolKey: RetipConfigBoolKey.debugInvertOversizedImages,
          ),
          DevSwitchListTile(
            boolKey: RetipConfigBoolKey.showPerformanceOverlay,
          ),
        ],
      ),
    );
  }
}
