import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/task_bloc/task_bloc.dart';
import '../models/task.dart';

// Pop виджеты для удаления и добавления задачи
void addTaskDialog(BuildContext context) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить задачу'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Введите описание'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Назад'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Добавить'),
            onPressed: () {
              final task = Task(id: Uuid().v4(), description: controller.text);
              context.read<TaskBloc>().add(AddTask(task));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showDeleteConfirmationDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Удалить задачу'),
        content: const Text('Действительно хотите удалить задачу?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Назад'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Удалить'),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTask(task));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}