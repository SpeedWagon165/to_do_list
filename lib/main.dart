import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list/themes/themes.dart';

import 'bloc/task_bloc/task_bloc.dart';
import 'ui/task_screen.dart';

void main() async {
  // Обеспечивает инициализацию всех необходимых компонентов Flutter.
  WidgetsFlutterBinding.ensureInitialized();
  // Асинхронно инициализирует локальное хранилище для HydratedBloc, используя путь к директории документов приложения.
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  // Запускает приложение в контексте, где доступно инициализированное хранилище.
  HydratedBlocOverrides.runZoned(
    // Запуск приложения.
        () => runApp(const MyApp()),
    // Установка инициализированного хранилища.
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Создание экземпляра TaskBloc, который будет доступен всем потомкам через контекст.
      create: (context) => TaskBloc(),
      child: MaterialApp(
        title: 'ToDo List',
        theme: darkTheme, // Используем темную тему из themes.dart
        home: const TaskScreen(),
      ),
    );
  }
}
