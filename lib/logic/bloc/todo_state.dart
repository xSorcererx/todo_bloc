// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

// defining different states for the home page/ todo container.
abstract class TodoState {}

abstract class TodoActionState extends TodoState{}

class TodoInitial extends TodoState {}

class  TodoFetchLoadingState extends TodoState {}

class  TodoFetchErrorState extends TodoState {}

class TodoFetchSuccesState extends TodoState {
  final List<TodoModel> todos;
  TodoFetchSuccesState({
    required this.todos,
  });
}

class TodoAdditionSuccessState extends TodoActionState {}

class TodoAdditionErrorState extends TodoActionState {}