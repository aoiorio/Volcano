import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/todo_dto.dart';
import 'package:volcano/presentation/provider/back/todo/todo_providers.dart';
import 'package:volcano/presentation/provider/front/post_todo/post_todo_controller.dart';

part 'execute_text_to_todo_controller.g.dart';

@riverpod
class TextToTodoController extends _$TextToTodoController {
  @override
  Either<BackEndError, TodoDTO> build() {
    return Either.left(BackEndError());
  }

  void executeTextToTodo(String voiceText) {
    final postTodoController = ref.read(postTodoControllerProvider.notifier);
    ref
        .read(todoUseCaseProvider)
        .executeTextToTodo(voiceText: voiceText)
        .then((value) {
      if (value.isRight()) {
        value.foldRight(BackEndError, (returnValue, todo) {
          postTodoController.titleTextController.text = todo.title ?? '';
          postTodoController.descriptionTextController.text =
              todo.description ?? '';
          postTodoController.typeTextController.text = todo.type ?? '';
          postTodoController.priority = todo.priority ?? 3;
          // ignore: cascade_invocations
          postTodoController.period = todo.period ?? DateTime.now();
          return returnValue;
        });
      }
    });
  }
}
