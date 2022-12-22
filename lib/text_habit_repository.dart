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
    return "$fileString${actionTime.microsecondsSinceEpoch}\n";
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
    getLogs().sort();
    String newFileString = "";
    getLogs().forEach(
        (element) => {newFileString = addToString(element, newFileString)});
    _file.writeAsStringSync(newFileString);
  }

  DateTime dateTimeFromString(element) {
    return DateTime.fromMicrosecondsSinceEpoch(int.parse(element));
  }

  String getFileString() {
    return _file.readAsStringSync();
  }

  List<DateTime> parseString(String s) {
    List<DateTime> logs = [];
    var timeStamps = s.split("\n");
    timeStamps.sublist(0, timeStamps.length - 1).forEach((element) {
      logs.add(DateTime.fromMicrosecondsSinceEpoch(int.parse(element)));
    });
    return logs;
  }
}
