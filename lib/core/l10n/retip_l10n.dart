import 'package:flutter/material.dart';
import 'locales/app_localizations.dart';

mixin RetipL10n {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static const localizationsDelegates = AppLocalizations.localizationsDelegates;

  static const supportedLocales = AppLocalizations.supportedLocales;
}
