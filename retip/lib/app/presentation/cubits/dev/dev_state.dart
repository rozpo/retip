part of 'dev_cubit.dart';

@immutable
final class DevState {
  final bool isEnabled;

  const DevState({this.isEnabled = false});

  DevState copyWith({int? stepsToBeDev, bool? isEnabled}) {
    return DevState(isEnabled: isEnabled ?? this.isEnabled);
  }

  @override
  String toString() {
    return 'isEnabled = $isEnabled';
  }
}
