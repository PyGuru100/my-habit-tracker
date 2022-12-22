class HabitTracker {
  final Timer _timer;
  final List<DateTime> _actions = [];

  HabitTracker([this._timer = Timer.instance]);

  int getCurrentCount() {
    return _actions.length;
  }

  void doBadHabit() {
    _actions.add(_timer.getCurrentTime());
  }

  DateTime getLastDone() {
    if (_actions.isNotEmpty) return _actions.last;
    return Timer.defaultInitialTime();
  }

  List<DateTime> getLogs() {
    return _actions;
  }
}

class Timer {
  static const Timer instance = Timer();

  const Timer();

  DateTime getCurrentTime() {
    return DateTime.now();
  }

  static Duration delta(DateTime first, DateTime second) {
    return first.difference(second);
  }

  static defaultInitialTime() {
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }
}
