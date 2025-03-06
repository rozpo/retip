import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RetipL10n {
  final localizationsDelegates = AppLocalizations.localizationsDelegates;
  final supportedLocales = AppLocalizations.supportedLocales;

  AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
