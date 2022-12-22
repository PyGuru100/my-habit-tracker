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
    String fileString = getFileString();
    addToString(actionTime, fileString);
    _file.writeAsString(fileString);
  }

  void addToString(DateTime actionTime, String fileString) {
    fileString += "${actionTime.microsecondsSinceEpoch}\n";
  }

  @override
  int getActionCount() {
    return getLogs().length;
  }

  @override
  List<DateTime> getLogs() {
    String fileString = getFileString();
    List<String> timestamps = fileString.split("\n");
    return timestamps
        .sublist(0, timestamps.length - 1)
        .map(dateTimeFromString)
        .toList();
  }

  @override
  bool isEmpty() {
    return getLogs().isEmpty;
  }

  @override
  void sortLogs() {
    getLogs().sort();
    String newFileString = "";
    getLogs().forEach((element) => addToString(element, newFileString));
    _file.writeAsString(newFileString);
  }

  DateTime dateTimeFromString(element) {
    return DateTime.fromMicrosecondsSinceEpoch(int.parse(element));
  }

  String getFileString() {
    String fileString = "";
    _file.readAsString().then((value) => fileString = value);
    return fileString;
  }
}
