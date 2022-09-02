import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
import 'package:todo_app/providers/pages_provider.dart';

import 'pages/task_manager_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for tasks storage
  await Hive.initFlutter();
  await Hive.openBox<Task>('userTasks');

  runApp(
    const TaskManagerApp(),
  );
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (
        ColorScheme? lightDynamic,
        ColorScheme? darkDynamic,
      ) {
        ColorScheme lightColorScheme, darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: fallbackMainColor,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: fallbackMainColor,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            fontFamily: 'Noto Sans Medium',
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            fontFamily: 'Noto Sans Medium',
            brightness: Brightness.dark,
          ),
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<PagesProvider>(
                create: (_) => PagesProvider(),
              ),
              ValueListenableProvider<Box<Task>>.value(
                  value: Hive.box<Task>('userTasks').listenable())
            ],
            child: const TaskManagerHome(),
          ),
        );
      },
    );
  }
}
