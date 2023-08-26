// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

// defining different events for the home page/ todo container.
abstract class TodoEvent {}

class TodoInitialFetchEvent extends TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final TodoModel todoModelData;

  TodoAddEvent({
    required this.todoModelData,
  });
}
