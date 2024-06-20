// ignore_for_file: implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/todo.dart';
import 'package:volcano/domain/repository/todo/todo_repository.dart';
import 'package:volcano/domain/usecase/todo/todo_use_case.dart';

class TodoUseCaseImpl implements TodoUseCase {
  TodoUseCaseImpl({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<BackEndError, Todo>> executePostTodo({required Todo todo}) {
    // TODO: implement executePostTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<BackEndError, Todo>> executeTextToTodo({
    required String voiceText,
  }) {
    return _todoRepository.textToTodo(voiceText: voiceText);
  }
}
