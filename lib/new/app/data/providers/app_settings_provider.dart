import 'package:app_settings/app_settings.dart';

class AppSettingsProvider {
  Future<void> openAppSettings() async {
    await AppSettings.openAppSettings();
  }
}
