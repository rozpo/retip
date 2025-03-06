extension IntExtension on int {
  String get size {
    const kilobyte = 1024;
    const megabyte = kilobyte * 1024;
    const gigabyte = megabyte * 1024;

    if (this < kilobyte) {
      return '${this}B';
    } else if (this < megabyte) {
      return '${(this / kilobyte).toStringAsPrecision(2)}KB';
    } else if (this < gigabyte) {
      return '${(this / megabyte).toStringAsPrecision(2)}MB';
    }

    return '${(this / gigabyte).toStringAsPrecision(2)}GB';
  }
}
