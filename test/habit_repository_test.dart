import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/text_habit_repository.dart';

void main() {
  TextHabitRepository habitsRepository = TextHabitRepository("temp.txt");

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
