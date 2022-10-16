// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tasks_object.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String taskName;

  @HiveField(1)
  DateTime? taskDue;

  @HiveField(2)
  DateTimeRange? taskETA;

  @HiveField(3)
  String? taskDescriptions;

  @HiveField(4)
  List<Subtask>? subtasks;

  @HiveField(5)
  int? completedSubtasksNum;

  @HiveField(6)
  bool isCompleted = false;
}

class Subtask extends Object {
  late String taskName;
  DateTimeRange? taskETA;
  bool isCompleted = false;
}
