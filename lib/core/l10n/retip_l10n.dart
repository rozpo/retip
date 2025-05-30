import 'package:flutter/material.dart';

import 'locales/app_localizations.dart';

class RetipL10n {
  final localizationsDelegates = AppLocalizations.localizationsDelegates;
  final supportedLocales = AppLocalizations.supportedLocales;

  AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
