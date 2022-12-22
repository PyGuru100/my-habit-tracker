import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/habit_tracker.dart';

void main() {
  var timer = MockTimer();
  HabitTracker habitTracker = HabitTracker(FakeHabitsRepository(), timer);
  test('Tracks all bad habits', () {
    expect(habitTracker.getLastDone(), DateTime.fromMicrosecondsSinceEpoch(0));
    expect(habitTracker.getCurrentCount(), 0);

    DateTime timeOfFirstAction = configureMockTimer(timer);
    habitTracker.doBadHabit();
    expect(habitTracker.getCurrentCount(), 1);
    expect(habitTracker.getLastDone(), timeOfFirstAction);

    DateTime timeOfSecondAction = configureMockTimer(timer);
    habitTracker.doBadHabit();
    expect(habitTracker.getCurrentCount(), 2);
    expect(habitTracker.getLastDone(), timeOfSecondAction);
  });

  test('Logs bad habits', () {
    habitTracker = HabitTracker(FakeHabitsRepository(), timer);
    expect(habitTracker.getLogs(), List.empty());
    var actionTime = configureMockTimer(timer);
    habitTracker.doBadHabit();
    expect(habitTracker.getLogs(), [actionTime]);
  });

  test('Default timer', () {
    DateTime time = DateTime.now();
    habitTracker = HabitTracker(FakeHabitsRepository());
    habitTracker.doBadHabit();
    expect(habitTracker.getCurrentCount(), 1);
    expect(false, Timer.delta(habitTracker.getLastDone(), time).isNegative);
  });
}

class FakeHabitsRepository extends HabitsRepository {
  final List<DateTime> _actions = [];

  @override
  void add(DateTime actionTime) {
    _actions.add(actionTime);
  }

  @override
  int getActionCount() {
    return _actions.length;
  }

  @override
  List<DateTime> getLogs() {
    return _actions;
  }

  @override
  bool isEmpty() {
    return _actions.isEmpty;
  }
}

DateTime configureMockTimer(MockTimer timer) {
  var timeOfAction = DateTime.now();
  timer.currentTime = timeOfAction;
  return timeOfAction;
}

class MockTimer extends Timer {
  DateTime currentTime = DateTime.now();

  @override
  DateTime getCurrentTime() {
    return currentTime;
  }
}
