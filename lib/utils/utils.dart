import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/task_bloc/task_bloc.dart';
import '../models/task.dart';


void addTaskDialog(BuildContext context) {
  final _controller = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter task description'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              final task = Task(id: Uuid().v4(), description: _controller.text);
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
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
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