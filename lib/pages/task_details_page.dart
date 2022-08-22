import 'package:flutter/material.dart';
import 'package:todo_app/components/task_summary_container.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/extensions/extensions.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({
    Key? key,
    required this.taskName,
    required this.taskDescriptions,
    required this.taskDue,
    required this.taskETA,
  }) : super(key: key);
  final String taskName, taskDescriptions;
  final DateTime taskDue;
  final Duration taskETA;

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
                    taskName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    'Due: ${taskDue.toApproxDateTime()}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    'ETA: ${taskETA.toApproxDurationString()}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(taskDescriptions),
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
              itemCount: 4,
              itemBuilder: (context, index) {
                return TaskSummaryContainer(
                  taskName: 'Test Task Name',
                  taskDue: DateTime.parse('2022-08-23 20:00:00'),
                  taskETA: const Duration(days: 1, hours: 1, minutes: 12),
                  subtasksNum: 4,
                );
              },
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
        onPressed: () {},
      ),
    );
  }
}
