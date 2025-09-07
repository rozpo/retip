abstract class AppInfoEntity {
  final DateTime? installTime;
  final DateTime? updateTime;
  final String version;
  final String name;
  final int number;
  final String id;

  const AppInfoEntity({
    required this.installTime,
    required this.updateTime,
    required this.version,
    required this.number,
    required this.name,
    required this.id,
  });
}
