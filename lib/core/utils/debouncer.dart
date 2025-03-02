import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration delay;

  Timer? _timer;

  Debouncer(this.delay);

  void run(VoidCallback callback) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(delay, callback);
  }

  void cancel(VoidCallback callback) {
    if (_timer != null) {
      _timer!.cancel();
    }

    callback.call();
  }
}
