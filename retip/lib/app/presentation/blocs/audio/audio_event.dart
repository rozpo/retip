part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {}

final class AudioInitializeEvent extends AudioEvent {}
