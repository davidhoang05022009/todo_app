import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_summary_container.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
import 'package:todo_app/pages/task_details_page.dart';
import 'package:todo_app/providers/pages_provider.dart';

import 'edit_or_add_task_page.dart';

class TaskManagerHome extends StatelessWidget {
  const TaskManagerHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<PagesProvider, Box<Task>>(
      builder: (context, pagesProvider, box, child) {
        final List<Task> tasks = box.values.toList().cast<Task>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pagesProvider.currentPageTitle,
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsPage(
                        task: task,
                      ),
                    ),
                  ),
                  child: TaskSummaryContainer(
                    taskName: task.taskName,
                    taskDue: task.taskDue,
                    taskETA: task.taskETA,
                    subtasksNum: task.subtasks.length,
                    completedSubtasksNum: task.completedSubtasksNum,
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add a task',
            child: const Icon(Icons.add_task_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditOrAddTaskPage(),
              ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: pagesProvider.pageIndex,
            onDestinationSelected: (newPageIndex) =>
                pagesProvider.updatePageIndex(newPageIndex),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                label: appTitles[0],
              ),
              NavigationDestination(
                icon: const Icon(Icons.star_outline),
                label: appTitles[1],
              ),
              NavigationDestination(
                icon: const Icon(Icons.calendar_month_outlined),
                label: appTitles[2],
              ),
            ],
          ),
        );
      },
    );
  }
}
