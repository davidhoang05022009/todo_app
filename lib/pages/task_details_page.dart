import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/subtask_container.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';

import 'edit_or_add_task_page.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  void markAllTasksAsCompleted() {
    task.isCompleted = true;
    for (Subtask subtask in task.subtasks) {
      subtask.isCompleted = true;
    }
    task.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: kPadding * 2, top: kPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    task.taskName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    'Due: In ${prettyDuration(
                      task.taskDue.difference(
                        DateTime.now(),
                      ),
                      tersity: DurationTersity.minute,
                    )} (${DateFormat.yMMMMEEEEd().format(task.taskDue)})',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    'ETA: ${prettyDuration(task.taskETA)}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(task.taskDescriptions),
                ),
                const Padding(
                  padding: EdgeInsets.all(kPadding),
                  child: Text('Sub-tasks:'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: task.subtasks.length,
              itemBuilder: (context, index) {
                Subtask subtask = task.subtasks[index];
                return SubtaskContainer(
                  taskName: subtask.taskName,
                  taskETA: subtask.taskETA,
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: TextButton.icon(
              onPressed: markAllTasksAsCompleted,
              icon: const Icon(Icons.check),
              label: const Text('Mark all as completed'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Edit this task',
        label: const Text(
          'Edit this task',
        ),
        icon: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditOrAddTaskPage(
              task: task,
            ),
          ),
        ),
      ),
    );
  }
}
