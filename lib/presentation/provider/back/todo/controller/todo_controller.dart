import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/infrastructure/dto/read_todo.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'todo_controller.g.dart';

@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  int typeCount = 0;
  @override
  Either<BackEndError, List<ReadTodo>> build() {
    return Either.right([]);
  }

  void executeReadTodo() {
    final token = ref.read(authSharedPreferenceProvider);
    // TODO remove progressControllerProvider and instead of that I will show Shimmer effect for it
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref.read(todoUseCaseProvider).executeReadTodo(token: token).then(
            (value) {
              if (value.isRight()) {
                value.getRight().fold(() => null, (todo) {
                  state = Either.right(todo);
                  typeCount = todo.length;
                });
                return Either.right(value);
              } else {
                value.getLeft().fold(() => null, (error) {
                  state = Either.left(error);
                  return Either.left(error);
                });
                return value;
              }
            },
          ),
        );
  }

  void executeLocalAddTodo(TodoDTO todo) {
    state.getRight().fold(() => null, (todos) {
      final index = todos.indexWhere((element) => element.type == todo.type);
      state.getRight().fold(() => null, (readTodoList) {
        // NOTE if the type is new
        if (index == -1) {
          readTodoList.add(ReadTodoDTO(type: todo.type, values: [todo]));
          state = Either.right([...readTodoList]);
          typeCount = readTodoList.length;
        } else {
          readTodoList[index].values!.add(todo);
          state = Either.right(readTodoList);
        }
      });
    });
  }
}
