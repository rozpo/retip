part of 'audio_bloc.dart';

@immutable
sealed class AudioState {
  const AudioState();
}

final class AudioInitState extends AudioState {
  const AudioInitState();
}

final class AudioIdleState extends AudioState {
  final int index;

  const AudioIdleState(this.index);

  @override
  bool operator ==(Object other) {
    return other is AudioIdleState && index == other.index;
  }

  @override
  int get hashCode => super.hashCode | index;

  @override
  String toString() {
    return 'INDEX: $index';
  }
}
