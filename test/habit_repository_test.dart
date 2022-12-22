import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/text_habit_repository.dart';

void main() {
  const String filePath = "test/temp.txt";

  File file = File(filePath);
  file.writeAsStringSync("940802400000000\n");

  DateTime myBirthday = DateTime(1999, DateTime.october, 25);

  TextHabitRepository habitsRepository = TextHabitRepository(filePath);

  test("Add to string", () {
    var once = habitsRepository.addToString(myBirthday, "");
    expect(once, "940802400000000\n");
    var twice = habitsRepository.addToString(myBirthday, once);
    expect(twice, "940802400000000\n940802400000000\n");
  });

  test("Parse String", () {
    expect(habitsRepository.parseString("940802400000000\n940802400000000\n"),
        [myBirthday, myBirthday]);
  });

  test("counts", () {
    DateTime firstActionTime = DateTime.now();
    DateTime secondActionTime = DateTime.now();
    DateTime thirdActionTime = DateTime.now();
    habitsRepository.add(firstActionTime);
    habitsRepository.add(secondActionTime);
    habitsRepository.add(thirdActionTime);
    expect(habitsRepository.getActionCount(), 4);
    expect(habitsRepository.getLogs(),
        [myBirthday, firstActionTime, secondActionTime, thirdActionTime]);
  });
}
