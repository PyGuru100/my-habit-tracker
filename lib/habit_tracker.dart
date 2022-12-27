import 'habit_repository.dart';

class HabitTracker {
  final Timer _timer;
  final HabitsRepository _habitsRepository;

  HabitTracker(this._habitsRepository, [this._timer = Timer.instance]);

  int getCurrentCount() {
    return _habitsRepository.getActionCount();
  }

  void doBadHabit() {
    _habitsRepository.add(_timer.getCurrentTime());
  }

  DateTime getLastDone() {
    if (_habitsRepository.isEmpty()) return Timer.defaultInitialTime();
    return _habitsRepository.getLogs().last;
  }

  List<DateTime> getLogs() {
    return _habitsRepository.getLogs();
  }

  void didBadHabit(DateTime actionTime) {
    _habitsRepository.add(actionTime);
    _habitsRepository.sortLogs();
  }

  bool neverDone() {
    return _habitsRepository.isEmpty();
  }

  int getActionId(DateTime actionTime) {
    return _habitsRepository.getActionId(actionTime);
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
