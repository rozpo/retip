part of 'permission_cubit.dart';

@immutable
class PermissionState {
  final bool isGranted;

  const PermissionState({
    this.isGranted = false,
  });

  PermissionState copyWith({
    bool? isGranted,
  }) {
    return PermissionState(
      isGranted: isGranted ?? this.isGranted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PermissionState && other.isGranted == isGranted;
  }

  @override
  int get hashCode => isGranted.hashCode;
}
