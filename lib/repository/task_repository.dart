import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../bloc/task_bloc/task_bloc.dart';
import '../models/task.dart';

class TaskRepository extends HydratedCubit<TaskState> {
  TaskRepository() : super(const TaskState());

  @override
  TaskState fromJson(Map<String, dynamic> json) {
    final tasks = (json['tasks'] as List).map((task) => Task(
      id: task['id'],
      description: task['description'],
      isCompleted: task['isCompleted'],
    )).toList();
    return TaskState(tasks: tasks);
  }

  @override
  Map<String, dynamic> toJson(TaskState state) {
    return {
      'tasks': state.tasks.map((task) => {
        'id': task.id,
        'description': task.description,
        'isCompleted': task.isCompleted,
      }).toList(),
    };
  }
}