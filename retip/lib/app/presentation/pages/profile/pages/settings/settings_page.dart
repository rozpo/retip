import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';

import '../../../../../../core/l10n/retip_l10n.dart';
import '../../../../../../core/router/retip_route.dart';
import '../../../../widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  final DevCubit devCubit;

  const SettingsPage({required this.devCubit, super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _taps = 0;

  void _handleTaps() {
    if (++_taps >= 10) {
      widget.devCubit.enable();
      _taps = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return BlocBuilder<DevCubit, DevState>(
      bloc: widget.devCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: !state.isEnabled ? _handleTaps : null,
              child: Text(l10n.settings),
            ),
          ),
          body: ListView(
            children: [
              SectionListTile(l10n.themeModeAndColors),
              ColorsListViewWidget(),
              SizedBox(height: 16),
              ThemeModeSegmentedButtonWidget(),
              SectionListTile('Grid size'),
              GridSizeSegmentedButtonWidget(),
              SectionListTile('Playback'),
              SwitchListTile(
                title: Text('Keep plaing queue'),
                subtitle: Text('Resume playback from last track'),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: Text('Autoplay'),
                subtitle: Text('Start playing on app startup'),
                value: false,
                onChanged: (value) {},
              ),
              SectionListTile('Power consumption'),
              SwitchListTile(
                title: Text('Battery saver'),
                subtitle: Text('Reduce animations in app'),
                value: false,
                onChanged: (value) {},
              ),
              if (state.isEnabled) ...[
                SectionListTile('Debug tools'),
                ListTile(
                  title: Text('Developer'),
                  subtitle: Text('Open developer menu board'),
                  leading: Icon(Icons.developer_board),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () => RetipRoute.dev.push(context),
                ),
                ListTile(
                  title: Text('Logger'),
                  subtitle: Text('View application logs'),
                  leading: Icon(Icons.monitor_heart),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () => RetipRoute.logger.push(context),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
