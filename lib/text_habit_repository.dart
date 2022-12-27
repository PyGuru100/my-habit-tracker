import 'dart:io';

import 'package:habit_tracker/habit_repository.dart';

class TextHabitRepository extends HabitsRepository {
  final String _filePath;
  late final File _file;

  TextHabitRepository(this._filePath) {
    _file = File(_filePath);
  }

  @override
  void add(DateTime actionTime) {
    _file.writeAsStringSync(addToString(actionTime, getFileString()));
  }

  String addToString(DateTime actionTime, String fileString) {
    return "$fileString${fromDateTime(actionTime)}\n";
  }

  @override
  int getActionCount() {
    return getLogs().length;
  }

  @override
  List<DateTime> getLogs() {
    return parseString(getFileString());
  }

  @override
  bool isEmpty() {
    return getLogs().isEmpty;
  }

  @override
  void sortLogs() {
    List<DateTime> logs = getLogs();
    logs.sort();
    String newFileString = "";
    for (DateTime value in logs) {
      newFileString = addToString(value, newFileString);
    }
    _file.writeAsStringSync(newFileString);
  }

  List<DateTime> parseString(String s) {
    List<DateTime> logs = [];
    var timeStamps = s.split("\n");
    timeStamps.sublist(0, timeStamps.length - 1).forEach((element) {
      logs.add(toDateTime(element));
    });
    return logs;
  }

  int fromDateTime(DateTime actionTime) => actionTime.microsecondsSinceEpoch;

  DateTime toDateTime(String element) {
    return DateTime.fromMicrosecondsSinceEpoch(int.parse(element));
  }

  String getFileString() {
    return _file.readAsStringSync();
  }

  @override
  int getActionId(DateTime action) {
    return getLogs().indexOf(action);
  }
}
