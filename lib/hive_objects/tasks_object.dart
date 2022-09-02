import 'package:hive_flutter/hive_flutter.dart';

part 'tasks_object.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String taskName;

  @HiveField(1)
  late DateTime taskDue;

  @HiveField(2)
  late Duration taskETA;

  @HiveField(3)
  late String taskDescriptions;

  @HiveField(4)
  late List<Subtask> subtasks;

  @HiveField(5)
  late int completedSubtasksNum;

  @HiveField(6)
  bool isCompleted = false;
}

class Subtask extends Object {
  late String taskName;
  late Duration taskETA;
  bool isCompleted = false;
}
