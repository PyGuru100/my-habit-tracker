

abstract class HabitsRepository {
  void add(DateTime actionTime);

  int getActionCount();

  bool isEmpty();

  List<DateTime> getLogs();

  int getActionId(DateTime action);

  void sortLogs();
}
