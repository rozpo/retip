import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<bool> _isOpen = List.generate(
    2,
    (index) => false,
    growable: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) => setState(() {
              _isOpen[panelIndex] = isExpanded;
            }),
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: _isOpen[0],
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    leading: Icon(Icons.visibility_outlined),
                    title: Text('Apperance'),
                  );
                },
                body: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(Icons.color_lens_outlined),
                      title: Text('Color'),
                    ),
                    ListTile(
                      leading: Icon(Icons.dark_mode_outlined),
                      title: Text('Theme mode'),
                    ),
                    ListTile(
                      leading: Icon(Icons.battery_std_outlined),
                      title: Text('Battery saver'),
                    ),
                  ],
                ),
              ),
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: _isOpen[1],
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    leading: Icon(Icons.play_arrow_outlined),
                    title: Text('Playback'),
                  );
                },
                body: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(Icons.music_note_outlined),
                      title: Text('Keep playling queue'),
                    ),
                    ListTile(
                      leading: Icon(Icons.battery_std_outlined),
                      title: Text('Battery saver'),
                    ),
                  ],
                ),
              ),
              // Divider(),
              // ListTile(
              //   onTap: () => showAboutDialog(context: context),
              //   leading: Icon(Icons.info_outlined),
              //   title: Text('About application'),
              //   trailing: Icon(Icons.arrow_forward),
              // ),
              // Divider(),
              // ListTile(
              //   onTap: () => showLicensePage(context: context),
              //   leading: Icon(Icons.description_outlined),
              //   title: Text('Licenses'),
              //   trailing: Icon(Icons.arrow_forward),
              // ),
              // ListTile(
              //   leading: Icon(Icons.privacy_tip_outlined),
              //   title: Text('Privacy policy'),
              //   trailing: Icon(Icons.public_outlined),
              // ),
              // ListTile(
              //   leading: Icon(Icons.gavel_outlined),
              //   title: Text('Terms and conditions'),
              //   trailing: Icon(Icons.public_outlined),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
