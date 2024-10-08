import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/infrastructure/dto/read_todo.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';

part 'todo_controller.g.dart';

@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  int typeCount = 0;
  @override
  Either<BackEndError, List<ReadTodo>> build() {
    return Either.left(BackEndError(statusCode: 100));
  }

  void executeReadTodo() {
    final token = ref.read(authSharedPreferenceProvider);
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
    );
  }

  void executeLocalAddTodo(TodoDTO todo) {
    state.getRight().fold(() => null, (readTodoList) {
      final index =
          readTodoList.indexWhere((element) => element.type == todo.type);
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
  }

  void executeLocalUpdateTodo(TodoDTO todo) {
    if (state.isLeft()) {
      return;
    }

    state.getRight().fold(() => null, (readTodoList) {
      var typeIndex =
          readTodoList.indexWhere((element) => element.type == todo.type);
      // TODO fix the bug of changing type, I can add previous type before changing
      if (typeIndex == -1) {
        // NOTE if the type doesn't exist
        readTodoList.add(ReadTodoDTO(type: todo.type, values: [todo]));
        typeIndex = readTodoList.length - 1;
      }
      final todoIndex = readTodoList[typeIndex]
          .values!
          .indexWhere((element) => element.todoId == todo.todoId);

      if (todoIndex == -1) {
        debugPrint('todo index is -1');
        // NOTE miss match
        return;
      }
      readTodoList[typeIndex].values![todoIndex] = todo;
      state = Either.right(readTodoList);
    });
  }

  void executeLocalDeleteTodo(TodoDTO todo) {
    if (state.isLeft()) {
      return;
    }

    state.getRight().fold(() => null, (readTodoList) {
      final typeIndex =
          readTodoList.indexWhere((element) => element.type == todo.type);

      if (typeIndex == -1) {
        return;
      }
      final todoIndex = readTodoList[typeIndex]
          .values!
          .indexWhere((element) => element.todoId == todo.todoId);

      if (todoIndex == -1) {
        return;
      }

      // NOTE remove todo here
      readTodoList[typeIndex].values!.removeAt(todoIndex);

      // NOTE if readTodoList doesn't have any values, remove the type
      if (readTodoList[typeIndex].values!.isEmpty) {
        typeCount--;
        readTodoList.removeAt(typeIndex);
      }

      state = Either.right(readTodoList);
    });
  }

  int? executeGetTypeIndex(String type) {
    if (state.isLeft()) {
      return -1;
    }

    final typeIndex = state.getRight().fold(() => null, (readTodoList) {
      final typeIndex =
          readTodoList.indexWhere((element) => element.type == type);

      if (typeIndex == -1) {
        return -1;
      }

      return typeIndex;
    });
    return typeIndex;
  }
}
