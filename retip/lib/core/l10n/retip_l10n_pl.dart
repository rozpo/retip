// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'retip_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class RetipL10nPl extends RetipL10n {
  RetipL10nPl([String locale = 'pl']) : super(locale);

  @override
  String get helloWorld => 'Witaj Świecie!';

  @override
  String get home => 'Start';

  @override
  String get library => 'Biblioteka';

  @override
  String get search => 'Szukaj';
}
