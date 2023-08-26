import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/data/models/todo_model.dart';
import 'package:todo_bloc/data/repos/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    // initial state of the app
    on<TodoInitialFetchEvent>((event, emit) async {
      // emitting loading state till app gets the todos from API
      emit(TodoFetchLoadingState());
      // adding 1 second extra delay for demonstration purposes.
      await Future.delayed(const Duration(seconds: 1));

      // Storing the to do models from the API in a list
      List<TodoModel> todos = await TodosRepo.fetchTodos();
      if (todos.isNotEmpty) {
        /* 
            sorting out the todos list according to the date.

            date formatter was initialised with required standard date format.
            And .sort() was used to sort the list in ascending order
        */
        final DateFormat formatter = DateFormat.yMd();
        todos.sort((a, b) =>
            formatter.parse(a.date).compareTo(formatter.parse(b.date)));
        // emitting to do success state with fetched todos list
        emit(TodoFetchSuccesState(todos: todos));
      } else {
        // emitting error state if todos is null
        emit(TodoFetchErrorState());
      }
    });

    // adding a to-do in the app
    on<TodoAddEvent>((event, emit) async {
      final isAdded = await TodosRepo.addTodos(event.todoModelData);
      if (isAdded) {
        emit(TodoAdditionSuccessState());
      } else {
        emit(TodoAdditionErrorState());
      }
    });
  }
}
