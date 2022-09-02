import 'package:duration/duration.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
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
  final DateTime taskDue;
  final Duration taskETA;
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
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(kPadding * 2, 0, 0, kPadding * 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  taskName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const Divider(
              indent: kPadding * 2,
              endIndent: kPadding * 2,
              thickness: 2,
            ),
            SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Due:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600, // Semi-bold
                          ),
                        ),
                        Text(
                          'In ${prettyDuration(
                            taskDue.difference(
                              DateTime.now(),
                            ),
                            tersity: DurationTersity.minute,
                          )}',
                          style: TextStyle(
                            color: taskDue.difference(DateTime.now()) <
                                    const Duration(hours: 1)
                                ? Colors.red.harmonizeWith(
                                    Theme.of(context).primaryColor)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    indent: kPadding,
                    endIndent: kPadding,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'ETA:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600, // Semi-bold
                          ),
                        ),
                        Text(
                          prettyDuration(taskETA),
                          style: TextStyle(
                            fontSize: 13,
                            color: taskETA > taskDue.difference(DateTime.now())
                                ? Colors.red.harmonizeWith(
                                    Theme.of(context).primaryColor)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    indent: kPadding,
                    endIndent: kPadding,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Completed sub-tasks:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600, // Semi-bold
                          ),
                        ),
                        Text(
                          '${completedSubtasksNum.toString()}/${subtasksNum.toString()}',
                        ),
                      ],
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
