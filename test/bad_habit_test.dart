import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/habit_repository.dart';
import 'package:habit_tracker/habit_tracker.dart';

void main() {
  FakeTimer timer = FakeTimer();
  HabitTracker habitTracker = HabitTracker(FakeHabitsRepository(), timer);

  setUp(() {
    timer = FakeTimer();
    habitTracker = HabitTracker(FakeHabitsRepository(), timer);
  });

  test('Get habit ID', () {
    DateTime firstActionTime = configureTimer(timer);
    habitTracker.doBadHabit();
    DateTime secondActionTime = configureTimer(timer);
    sleep(const Duration(milliseconds: 100));
    DateTime thirdActionTime = configureTimer(timer);
    habitTracker.doBadHabit();

    habitTracker.didBadHabit(secondActionTime);

    expect(0, habitTracker.getActionId(firstActionTime));
    expect(1, habitTracker.getActionId(secondActionTime));
    expect(2, habitTracker.getActionId(thirdActionTime));
  });

  test('Never done', () {
    expect(true, habitTracker.neverDone());
    habitTracker.doBadHabit();
    expect(false, habitTracker.neverDone());
  });

  test('Tracks all bad habits', () {
    expect(habitTracker.getLastDone(), DateTime.fromMicrosecondsSinceEpoch(0));
    expect(habitTracker.getCurrentCount(), 0);

    DateTime timeOfFirstAction = configureTimer(timer);
    habitTracker.doBadHabit();
    expect(habitTracker.getCurrentCount(), 1);
    expect(habitTracker.getLastDone(), timeOfFirstAction);

    DateTime timeOfSecondAction = configureTimer(timer);
    habitTracker.doBadHabit();
    expect(habitTracker.getCurrentCount(), 2);
    expect(habitTracker.getLastDone(), timeOfSecondAction);
  });

  test('Logs bad habits', () {
    habitTracker = HabitTracker(FakeHabitsRepository(), timer);
    expect(habitTracker.getLogs(), List.empty());
    var actionTime = configureTimer(timer);
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

  test('Adds delayed habit in order', () {
    DateTime lastActionTime = DateTime(2021);
    DateTime middleActionTime = DateTime(2020);
    DateTime firstActionTime = DateTime(2019);

    timer.currentTime = lastActionTime;
    habitTracker.doBadHabit();
    habitTracker.didBadHabit(firstActionTime);
    habitTracker.didBadHabit(middleActionTime);

    expect(habitTracker.getCurrentCount(), 3);
    expect(habitTracker.getLogs(),
        [firstActionTime, middleActionTime, lastActionTime]);
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

  @override
  void sortLogs() {
    _actions.sort();
  }

  @override
  int getActionId(DateTime action) {
    return _actions.indexOf(action);
  }
}

DateTime configureTimer(FakeTimer timer) {
  var timeOfAction = DateTime.now();
  timer.currentTime = timeOfAction;
  return timeOfAction;
}

class FakeTimer extends Timer {
  DateTime currentTime = DateTime.now();

  @override
  DateTime getCurrentTime() {
    return currentTime;
  }
}
