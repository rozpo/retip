extension DateTimeExtension on DateTime {
  String get toDisplayDateTime {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');

    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');

    return '$day.$month.$year $hour:$minute';
  }
}
