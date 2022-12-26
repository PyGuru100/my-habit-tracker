import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tracker.dart';
import 'package:habit_tracker/text_habit_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const HabitTrackerUI());
}

class HabitTrackerUI extends StatelessWidget {
  const HabitTrackerUI({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String filePath = "./appdata/habits.txt";
    File file = File(filePath);
    file.createSync(recursive: true);
    HabitTracker habitTracker = HabitTracker(TextHabitRepository(filePath));
    return MaterialApp(
        title: 'Habit Tracker',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(habitTracker, title: 'Habit Tracker'));
  }
}

class HomePage extends StatefulWidget {
  const HomePage(this._habitTracker, {Key? key, required this.title})
      : super(key: key);

  final String title;
  final HabitTracker _habitTracker;

  @override
  State<HomePage> createState() => _HomePageState(_habitTracker);
}

class _HomePageState extends State<HomePage> {
  final HabitTracker _habitTracker;

  _HomePageState(this._habitTracker);

  void doBadHabit() {
    setState(() {
      _habitTracker.doBadHabit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have done your bad habit last:'),
              Text(_habitTracker.getLastDone().toString())
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: doBadHabit,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
