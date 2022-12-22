import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/habit_tracker.dart';

void main() {
  var timer = MockTimer();
  HabitTracker habitTracker = HabitTracker(timer);
  test('Tracks all bad habits', () {
    expect(habitTracker.getLastDone(), null);
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
    habitTracker = HabitTracker(timer);
    expect(habitTracker.getLogs(), List.empty());
    var actionTime = configureMockTimer(timer);
    habitTracker.doBadHabit();
    expect(habitTracker.getLogs(), [actionTime]);
  });
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
