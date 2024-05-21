import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';




class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    // Регистрация обработчиков событий
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }
  // Для добавления элемента списка
  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    emit(TaskState(tasks: updatedTasks));
  }
  // Выполнена или нет
  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final updatedTasks = state.tasks.map((task) {
      return task.id == event.task.id ? event.task : task;
    }).toList();
    emit(TaskState(tasks: updatedTasks));
  }
  // Удаление задачи
  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final updatedTasks = state.tasks.where((task) => task.id != event.task.id).toList();
    emit(TaskState(tasks: updatedTasks));
  }

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
