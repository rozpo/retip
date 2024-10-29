extension DurationExtension on Duration {
  String get text {
    final String hours = (inHours % 24).toString();
    final String minutes = (inMinutes % 60).toString().padLeft(2, '0');
    final String seconds = (inSeconds % 60).toString().padLeft(2, '0');

    return '${inHours > 1 ? '$hours:' : ''}$minutes:$seconds';
  }
}
