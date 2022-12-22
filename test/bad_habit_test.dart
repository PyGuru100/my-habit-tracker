import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/habit_tracker.dart';

void main() {
  var timer = MockTimer();
  HabitTracker habitTracker = HabitTracker(timer);
  test('Tracks all bad habits', () {
    expect(habitTracker.getLastDone(), null);
    expect(habitTracker.getCurrentCount(), 0);

    habitTracker.doBadHabit();
    var timeOfAction = DateTime.now();
    timer.currentTime = timeOfAction;
    expect(habitTracker.getCurrentCount(), 1);
    expect(habitTracker.getLastDone(), timeOfAction);

    habitTracker.doBadHabit();
    expect(habitTracker.getCurrentCount(), 2);
  });
}

class MockTimer extends Timer {
  DateTime currentTime = DateTime.now();

  @override
  DateTime getCurrentTime() {
    return currentTime;
  }
}
