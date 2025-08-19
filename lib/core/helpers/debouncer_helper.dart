import 'dart:async';
import 'dart:ui';

class DebouncerHelper {
  final int milliseconds;
  DebouncerHelper({required this.milliseconds});

  Timer? _timer;

  void run(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), callback);
  }
}
