import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/extensions/date_time_extension.dart';
import 'package:retip/app/presentation/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/config/retip_config.dart';
import '../../../../../../core/l10n/retip_l10n.dart';
import '../../../../cubits/app_info/app_info_cubit.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return BlocBuilder<AppInfoCubit, AppInfoState>(
      builder: (context, state) {
        final version = state.data.version;

        return Scaffold(
          appBar: AppBar(title: Text('App info')),
          body: ListView(
            children: [
              SectionListTile('Info'),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(l10n.version),
                subtitle: Text(version),
              ),
              ListTile(
                title: Text(l10n.licenses),
                subtitle: Text(l10n.showThirdPartyLicenses),
                leading: Icon(Icons.description),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => showLicensePage(
                  applicationIcon: FlutterLogo(size: 69),
                  applicationLegalese: l10n.appLegalese,
                  applicationName: l10n.appName,
                  applicationVersion: version,
                  context: context,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.update),
                title: Text('Check for updates'),
                subtitle: Text(
                  'Last updated at: ${state.data.updateTime?.toDisplayDateTime}',
                ),
              ),
              Divider(),
              ListTile(
                title: Text(l10n.termsAndConditions),
                leading: Icon(Icons.gavel),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(RetipConfig.termsAndConditionsUrl),
              ),
              ListTile(
                title: Text(l10n.privacyPolicy),
                leading: Icon(Icons.privacy_tip),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(RetipConfig.privacyPolicyUrl),
              ),
              ListTile(
                title: Text('Repository'),
                leading: Icon(Icons.source),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(RetipConfig.repositoryUrl),
              ),
              ListTile(
                title: Text('Discord'),
                leading: Icon(Icons.discord),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(RetipConfig.discordUrl),
              ),
            ],
          ),
        );
      },
    );
  }
}
