import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class EditOrAddTaskPage extends StatefulWidget {
  const EditOrAddTaskPage({
    Key? key,
    this.task,
  }) : super(key: key);

  final Task? task;

  @override
  State<EditOrAddTaskPage> createState() => _EditOrAddTaskPageState();
}

class _EditOrAddTaskPageState extends State<EditOrAddTaskPage> {
  late String? taskName, taskDescriptions;
  late DateTime? taskDue;
  late Duration? taskETA;
  late List<Subtask>? subtasks;
  late TextEditingController taskNameEditingController;
  late TextEditingController taskDescriptionsEditingController;
  late bool isNewTask;

  @override
  void initState() {
    taskName = widget.task?.taskName;
    taskDescriptions = widget.task?.taskDescriptions;
    taskDue = widget.task?.taskDue;
    taskETA = widget.task?.taskETA;
    isNewTask = taskName == null;

    taskNameEditingController = TextEditingController();
    taskDescriptionsEditingController = TextEditingController();

    taskNameEditingController.text = taskName ?? '';
    taskDescriptionsEditingController.text = taskDescriptions ?? '';
    super.initState();
  }

  @override
  void dispose() {
    taskNameEditingController.dispose();
    taskDescriptionsEditingController.dispose();
    super.dispose();
  }

  Future<void> setNewTaskDue() async {
    final DateTime? newTaskDue = await showDatePicker(
      context: context,
      initialDate: taskDue ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    final TimeOfDay? newTaskDueTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(taskDue ?? DateTime.now()),
    );

    if (newTaskDue != null && newTaskDueTime != null && newTaskDue != taskDue) {
      setState(
        () {
          taskDue = DateTime(
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

  Future<void> setNewTaskETA() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTask ? 'Create a new task' : 'Edit',
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
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Row(
                    children: [
                      const Text('Due: '),
                      ElevatedButton.icon(
                        onPressed: setNewTaskDue,
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          taskDue != null
                              ? '${DateFormat.yMMMMEEEEd().format(taskDue!)} ${DateFormat.Hm().format(taskDue!)} '
                              : 'Add task Due',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Row(
                    children: [
                      const Text('ETA: '),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          taskETA != null
                              ? 'In ${prettyDuration(taskETA!)}'
                              : 'Add task Due',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
