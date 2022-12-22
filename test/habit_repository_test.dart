import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/text_habit_repository.dart';

void main() {
  TextHabitRepository habitsRepository = TextHabitRepository("test/temp.txt");

  test("Add to string", () {
    DateTime dateTime = DateTime(1999, DateTime.october, 25);
    var once = habitsRepository.addToString(dateTime, "");
    expect(once, "940802400000000\n");
    var twice = habitsRepository.addToString(dateTime, once);
    expect(twice, "940802400000000\n940802400000000\n");
  });

  test("Parse String", () {
    DateTime dateTime = DateTime(1999, DateTime.october, 25);
    expect(habitsRepository.parseString("940802400000000\n940802400000000\n"),
        [dateTime, dateTime]);
  });

  test("counts", () {
    DateTime firstActionTime = DateTime.now();
    DateTime secondActionTime = DateTime.now();
    DateTime thirdActionTime = DateTime.now();
    habitsRepository.add(firstActionTime);
    habitsRepository.add(secondActionTime);
    habitsRepository.add(thirdActionTime);
    expect(habitsRepository.getActionCount(), 3);
    expect(habitsRepository.getLogs(),
        [firstActionTime, secondActionTime, thirdActionTime]);
  });
}
