class HabitTracker {
  int _currentCount = 0;
  DateTime? _lastDone;
  final Timer _timer;

  HabitTracker(this._timer);

  getCurrentCount() {
    _lastDone = _timer.getCurrentTime();
    return _currentCount;
  }

  doBadHabit() {
    _currentCount++;
  }

  getLastDone() {
    return _lastDone;
  }
}

class Timer {
  DateTime getCurrentTime() {
    return DateTime.now();
  }

  static Duration delta(DateTime first, DateTime second) {
    return first.difference(second);
  }
}
