import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_summary_container.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/pages/task_details_page.dart';
import 'package:todo_app/providers/pages_provider.dart';

class TaskManagerHome extends StatelessWidget {
  const TaskManagerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (context, pagesProvider, child) {
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsPage(
                        taskName: 'Test Task Name',
                        taskDescriptions: 'taskDescriptions',
                        taskDue: DateTime.parse('2022-08-23 20:00:00'),
                        taskETA: const Duration(minutes: 15),
                      ),
                    ),
                  ),
                  child: TaskSummaryContainer(
                    taskName: 'Test Task Name',
                    taskDue: DateTime.parse('2022-08-23 20:00:00'),
                    taskETA: const Duration(days: 1, hours: 1, minutes: 12),
                    subtasksNum: 4,
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add a task',
            child: const Icon(Icons.add_task_outlined),
            onPressed: () {},
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
