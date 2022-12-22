class HabitTracker {
  final Timer _timer;
  final List<DateTime> _actions = [];

  HabitTracker(this._timer);

  getCurrentCount() {
    return _actions.length;
  }

  doBadHabit() {
    _actions.add(_timer.getCurrentTime());
  }

  getLastDone() {
    if (_actions.isNotEmpty) return _actions.last;
    return null;
  }

  List<DateTime> getLogs() {
    return _actions;
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
