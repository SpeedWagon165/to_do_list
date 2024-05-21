import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;  //Уникальный идентификатор задачи.
  final String description; //Описание задачи.
  final bool isCompleted; //Флаг, указывающий, выполнена ли задача.

  const Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });
  // Позволяет создать копию существующей задачи с изменением некоторых свойств. Когда необходимо изменить одно или несколько свойств объекта.
  Task copyWith({String? id, String? description, bool? isCompleted}) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  // Метод props для Equatable, который возвращает список свойств для сравнения
  @override
  List<Object> get props => [id, description, isCompleted];
}