import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_cubit/todo/model/todo_model.dart';

part 'todo_state.dart';
part 'todo_cubit.freezed.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const _Initial());

  void loadTodos() => emit(
        const _Loaded(),
      );

  void addTodo(String todo) => state.maybeMap(
        loaded: (state) => emit(
          state.copyWith(
            todos: List.from(state.todos)
              ..add(
                TodoModel(task: todo),
              ),
          ),
        ),
        orElse: () => null,
      );

  void deleteTodo(int index) => state.maybeMap(
        loaded: (state) => emit(
          state.copyWith(
            todos: List.from(state.todos)..removeAt(index),
          ),
        ),
        orElse: () => null,
      );

  void toggleTodo(int index) => state.maybeMap(
        loaded: (state) {
          final todo =
              state.todos[index].copyWith(isDone: !state.todos[index].isDone);
          emit(
            state.copyWith(
              todos: List.from(state.todos)
                ..replaceRange(index, index + 1, [todo]),
            ),
          );
        },
        orElse: () => null,
      );
}
