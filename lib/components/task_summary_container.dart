import 'package:duration/duration.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants.dart';

class TaskSummaryContainer extends StatelessWidget {
  const TaskSummaryContainer({
    Key? key,
    required this.taskName,
    required this.taskDue,
    required this.taskETA,
    required this.subtasksNum,
    required this.completedSubtasksNum,
  }) : super(key: key);

  final String taskName;
  final DateTime? taskDue;
  final DateTimeRange? taskETA;
  final int subtasksNum, completedSubtasksNum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(kPadding * 1.5),
                padding: const EdgeInsets.all(kPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    taskName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )),
            Container(
              margin: const EdgeInsets.all(kPadding),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_month),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Due: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600, // Semi-bold
                            ),
                          ),
                          TextSpan(
                            text: taskDue == null
                                ? 'No due'
                                : 'In ${prettyDuration(
                                    taskDue!.difference(
                                      DateTime.now(),
                                    ),
                                    tersity: DurationTersity.minute,
                                  )}',
                            style: TextStyle(
                              color: taskDue == null ||
                                      taskDue!.difference(DateTime.now()) <
                                          const Duration(hours: 1)
                                  ? Colors.red.harmonizeWith(
                                      Theme.of(context).primaryColor)
                                  : null,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'ETA: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600, // Semi-bold
                            ),
                          ),
                          TextSpan(
                            text: taskETA == null
                                ? 'No ETA'
                                : 'In ${prettyDuration(taskETA!.duration)} (${DateFormat.yMMMd().format(taskETA!.start)} ${DateFormat.Hm().format(taskETA!.start)} - ${DateFormat.yMMMd().format(taskETA!.end)} ${DateFormat.Hm().format(taskETA!.end)})',
                            style: TextStyle(
                              fontSize: 13,
                              color: taskETA == null ||
                                      taskETA!.duration >
                                          taskDue!.difference(DateTime.now())
                                  ? Colors.red.harmonizeWith(
                                      Theme.of(context).primaryColor)
                                  : null,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Completed sub-tasks: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600, // Semi-bold
                            ),
                          ),
                          TextSpan(
                            text:
                                '${completedSubtasksNum.toString()}/${subtasksNum.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
