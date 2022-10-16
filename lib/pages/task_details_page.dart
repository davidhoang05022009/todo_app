import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/subtask_container.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
import 'package:todo_app/providers/current_task_provider.dart';

import 'edit_or_add_task_page.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentTaskProvider>(
      builder: (context, currentTaskProvider, child) {
        void markAllTasksAsCompleted() {
          currentTaskProvider.task.isCompleted = true;
          for (Subtask subtask in currentTaskProvider.task.subtasks!) {
            subtask.isCompleted = true;
          }
          currentTaskProvider.task.save();
        }

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
                margin: const EdgeInsets.only(
                    left: kPadding * 2, top: kPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kPadding),
                      child: Text(
                        currentTaskProvider.task.taskName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPadding),
                      child: Text(
                        'Due: In ${prettyDuration(
                          currentTaskProvider.task.taskDue!.difference(
                            DateTime.now(),
                          ),
                          tersity: DurationTersity.minute,
                        )} (${DateFormat.yMMMMEEEEd().format(currentTaskProvider.task.taskDue!)})',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPadding),
                      child: Text(
                        currentTaskProvider.task.taskETA == null
                            ? 'No ETA'
                            : 'ETA: ${prettyDuration(currentTaskProvider.task.taskETA!.duration)} (${DateFormat.yMMMd().format(currentTaskProvider.task.taskETA!.start)} ${DateFormat.Hm().format(currentTaskProvider.task.taskETA!.start)} - ${DateFormat.yMMMd().format(currentTaskProvider.task.taskETA!.end)} ${DateFormat.Hm().format(currentTaskProvider.task.taskETA!.end)})',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPadding),
                      child:
                          Text(currentTaskProvider.task.taskDescriptions ?? ''),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(kPadding),
                      child: Text('Sub-tasks:'),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: currentTaskProvider.task.subtasks != null,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: currentTaskProvider.task.subtasks == null
                        ? 0
                        : currentTaskProvider.task.subtasks!.length,
                    itemBuilder: (context, index) {
                      Subtask subtask =
                          currentTaskProvider.task.subtasks![index];
                      return SubtaskContainer(
                        taskName: subtask.taskName,
                        taskETA: subtask.taskETA!,
                      );
                    },
                  ),
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditOrAddTaskPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
