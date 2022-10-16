import 'package:flutter/material.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
import 'package:hive/hive.dart';

class CurrentTaskProvider extends ChangeNotifier {
  Task task = Task();

  void selectTask(Task selectedTask) {
    task = selectedTask;
    notifyListeners();
  }

  void saveTask(Box<Task> box, Task taskToSave) {
    task
      ..completedSubtasksNum = taskToSave.completedSubtasksNum
      ..isCompleted = taskToSave.isCompleted
      ..subtasks = taskToSave.subtasks
      ..taskDescriptions = taskToSave.taskDescriptions
      ..taskDue = taskToSave.taskDue
      ..taskETA = taskToSave.taskETA;

    try {
      task.save();
    } catch (exception) {
      box.add(task);
    }
    flushTask();
    notifyListeners();
  }

  void deleteTask() {
    task.delete();
    flushTask();
    notifyListeners();
  }

  void flushTask() {
    task = Task();
    notifyListeners();
  }
}
