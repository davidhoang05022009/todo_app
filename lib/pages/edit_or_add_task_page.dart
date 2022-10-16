import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/current_task_provider.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';

class EditOrAddTaskPage extends StatefulWidget {
  const EditOrAddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditOrAddTaskPage> createState() => _EditOrAddTaskPageState();
}

class _EditOrAddTaskPageState extends State<EditOrAddTaskPage> {
  late TextEditingController taskNameEditingController;
  late TextEditingController taskDescriptionsEditingController;

  @override
  void initState() {
    taskNameEditingController = TextEditingController();
    taskDescriptionsEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    taskNameEditingController.dispose();
    taskDescriptionsEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CurrentTaskProvider, Box<Task>>(
      builder: (context, currentTaskProvider, box, child) {
        Task temporaryTask = currentTaskProvider.task;
        bool isNewTask = temporaryTask == Task();
        taskNameEditingController.text =
            isNewTask ? '' : temporaryTask.taskName;
        taskDescriptionsEditingController.text =
            isNewTask ? '' : temporaryTask.taskDescriptions!;

        Future<void> setNewTaskDue() async {
          final DateTime? newTaskDueDate = await showDatePicker(
            context: context,
            initialDate: temporaryTask.taskDue ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 100),
          );

          final TimeOfDay? newTaskDueTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
              temporaryTask.taskDue ?? DateTime.now(),
            ),
          );

          if (newTaskDueDate != null && newTaskDueTime != null) {
            final DateTime newTaskDue = DateTime(
              newTaskDueDate.year,
              newTaskDueDate.month,
              newTaskDueDate.day,
              newTaskDueTime.hour,
              newTaskDueTime.minute,
            );
            if (newTaskDue != temporaryTask.taskDue) {
              setState(
                () {
                  temporaryTask.taskDue = DateTime(
                    newTaskDue.year,
                    newTaskDue.month,
                    newTaskDue.day,
                    newTaskDueTime.hour,
                    newTaskDueTime.minute,
                  );
                },
              );
            }
          }
        }

        Future<void> setNewTaskETA() async {
          final DateTimeRange? newTaskETADate = await showDateRangePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 100),
          );

          final TimeOfDay? newTaskETAStartTime = await showTimePicker(
            helpText: 'START TIME',
            context: context,
            initialTime: TimeOfDay.now(),
          );

          final TimeOfDay? newTaskETAEndTime = await showTimePicker(
            helpText: 'END TIME',
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (newTaskETADate != null &&
              newTaskETAStartTime != null &&
              newTaskETAEndTime != null) {
            final DateTimeRange newTaskETA = DateTimeRange(
              start: DateTime(
                  newTaskETADate.start.year,
                  newTaskETADate.start.month,
                  newTaskETADate.start.day,
                  newTaskETAStartTime.hour,
                  newTaskETAStartTime.minute),
              end: DateTime(
                  newTaskETADate.end.year,
                  newTaskETADate.end.month,
                  newTaskETADate.end.day,
                  newTaskETAEndTime.hour,
                  newTaskETAEndTime.minute),
            );

            if (newTaskETA != temporaryTask.taskETA) {
              setState(
                () {
                  temporaryTask.taskETA = newTaskETA;
                },
              );
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              temporaryTask == Task() ? 'Create a new task' : 'Edit task',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            centerTitle: true,
            actions: [
              Tooltip(
                message: 'Save task',
                child: IconButton(
                  onPressed: () {
                    temporaryTask.taskName = taskNameEditingController.text;
                    temporaryTask.taskDescriptions =
                        taskDescriptionsEditingController.text;
                    currentTaskProvider.saveTask(box, temporaryTask);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                ),
              ),
            ],
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
                      child: TextField(
                        controller: taskNameEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Complete my homework',
                          labelText: 'Task name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPadding),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: TextField(
                          maxLines: null,
                          controller: taskDescriptionsEditingController,
                          decoration: const InputDecoration(
                            hintText:
                                'Today\'s homeworks are maths, literature, sciences and physics',
                            labelText: 'Task descriptions',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(kPadding),
                              child: const Text('Due:'),
                            ),
                            Container(
                              margin: const EdgeInsets.all(kPadding),
                              child: const Text('ETA:'),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(kPadding),
                              child: ElevatedButton.icon(
                                onPressed: setNewTaskDue,
                                icon: const Icon(Icons.calendar_month),
                                label: Text(
                                  temporaryTask.taskDue == null
                                      ? 'Add task Due'
                                      : '${DateFormat.yMMMMEEEEd().format(temporaryTask.taskDue!)} ${DateFormat.Hm().format(temporaryTask.taskDue!)}',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(kPadding),
                              child: ElevatedButton.icon(
                                onPressed: setNewTaskETA,
                                icon: const Icon(Icons.timer),
                                label: Text(temporaryTask.taskETA == null
                                    ? 'Add task ETA'
                                    : 'In ${prettyDuration(temporaryTask.taskETA!.duration)} (${DateFormat.yMMMd().format(temporaryTask.taskETA!.start)} ${DateFormat.Hm().format(temporaryTask.taskETA!.start)} - ${DateFormat.yMMMd().format(temporaryTask.taskETA!.end)} ${DateFormat.Hm().format(temporaryTask.taskETA!.end)})'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
