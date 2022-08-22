import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/pages_provider.dart';

import 'pages/task_manager_home.dart';

void main() {
  runApp(
    const TaskManagerApp(),
  );
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (
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
        home: ChangeNotifierProvider<PagesProvider>(
          create: (_) => PagesProvider(),
          child: const TaskManagerHome(),
        ),
      );
    });
  }
}
