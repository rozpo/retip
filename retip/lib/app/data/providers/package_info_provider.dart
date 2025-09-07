import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoProvider {
  final PackageInfo _packageInfo;

  static Future<PackageInfoProvider> init() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return PackageInfoProvider._(packageInfo);
  }

  const PackageInfoProvider._(this._packageInfo);

  String get id => _packageInfo.packageName;

  String get name => _packageInfo.appName;

  String get version => _packageInfo.version;

  String get number => _packageInfo.buildNumber;

  DateTime? get installTime => _packageInfo.installTime;

  DateTime? get updateTime => _packageInfo.updateTime;
}
