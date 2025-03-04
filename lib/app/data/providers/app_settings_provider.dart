import 'package:app_settings/app_settings.dart';

class AppSettingsProvider {
  static Future<AppSettingsProvider> init() async {
    return AppSettingsProvider();
  }

  Future<void> openAppSettings() async {
    return await AppSettings.openAppSettings();
  }
}
