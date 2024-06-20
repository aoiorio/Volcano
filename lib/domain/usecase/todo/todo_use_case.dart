import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/todo.dart';

abstract class TodoUseCase {
  Future<Either<BackEndError, Todo>> executeTextToTodo({
    required String voiceText,
  });

  Future<Either<BackEndError, Todo>> executePostTodo({
    required Todo todo,
  });

  // TODO create other methods
}
