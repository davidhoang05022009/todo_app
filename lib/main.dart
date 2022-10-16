import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/hive_objects/tasks_object.dart';
import 'package:todo_app/providers/current_task_provider.dart';

import 'pages/todo_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for tasks storage
  await Hive.initFlutter();
  Hive.registerAdapter(
    TaskAdapter(),
  );
  await Hive.openBox<Task>('userTasks');

  runApp(
    MultiProvider(
      providers: [
        ValueListenableProvider<Box<Task>>.value(
          value: Hive.box<Task>('userTasks').listenable(),
        ),
        ChangeNotifierProvider<CurrentTaskProvider>(
          create: (_) => CurrentTaskProvider(),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

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
          debugShowCheckedModeBanner: false,
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
          home: const TodoHome(),
        );
      },
    );
  }
}
