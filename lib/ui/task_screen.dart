import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc/task_bloc.dart';
import '../utils/utils.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(task.description),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        context.read<TaskBloc>().add(
                          UpdateTask(task.copyWith(isCompleted: value)),
                        );
                      },
                    ),
                    onLongPress: () {
                      showDeleteConfirmationDialog(context, task);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addTaskDialog(context);
        },
      ),
    );
  }}