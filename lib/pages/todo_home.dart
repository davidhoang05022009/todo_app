import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_summary_container.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
import 'package:todo_app/pages/task_details_page.dart';
import 'package:todo_app/providers/current_task_provider.dart';

import 'edit_or_add_task_page.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<CurrentTaskProvider, Box<Task>>(
      builder: (context, currentTaskProvider, box, child) {
        final List<Task> tasks = box.values.toList().cast<Task>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "My todos",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {},
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return InkWell(
                  onTap: () {
                    currentTaskProvider.selectTask(task);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TaskDetailsPage(),
                      ),
                    );
                  },
                  child: TaskSummaryContainer(
                    taskName: task.taskName,
                    taskDue: task.taskDue,
                    taskETA: task.taskETA,
                    subtasksNum:
                        task.subtasks != null ? task.subtasks!.length : 0,
                    completedSubtasksNum: task.completedSubtasksNum ?? 0,
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add a task',
            child: const Icon(Icons.add_task_outlined),
            onPressed: () {
              currentTaskProvider.selectTask(Task());
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
