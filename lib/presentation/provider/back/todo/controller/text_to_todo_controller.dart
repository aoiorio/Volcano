import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/page/dialogs/add_todo_dialog.dart';
import 'package:volcano/presentation/provider/back/todo/controller/post_todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'text_to_todo_controller.g.dart';

@Riverpod(keepAlive: true)
class TextToTodoController extends _$TextToTodoController {
  @override
  Either<BackEndError, TodoDTO> build() {
    return Either.left(BackEndError());
  }

  void executeTextToTodo(String voiceText, FToast toast, BuildContext context) {
    final postTodoController = ref.read(postTodoControllerProvider.notifier);
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(todoUseCaseProvider)
              .executeTextToTodo(voiceText: voiceText)
              .then((value) {
            if (value.isRight()) {
              value.getRight().fold(() => null, (todo) {
                postTodoController.titleTextController.text = todo.title ?? '';
                postTodoController.descriptionTextController.text =
                    todo.description ?? '';
                postTodoController.typeTextController.text = todo.type ?? '';
                postTodoController.priority = todo.priority ?? 3;
                final utcPeriod = todo.period ?? DateTime.now();
                ref.read(todoPeriodProvider.notifier).state =
                    utcPeriod.toLocal();
              });
              showAddTodoDialog(context);
            } else if (value.isLeft()) {
              value.getLeft().fold(() => null, (error) {
                showToastMessage(
                  toast,
                  '😵‍💫 Something went wrong with recognizing audio',
                  ToastWidgetKind.error,
                );
                return Either.left(BackEndError());
              });
              // showToastMessage(toast, message, kind)
            } else {
              showToastMessage(
                toast,
                '😵‍💫 Something went wrong',
                ToastWidgetKind.error,
              );
              return Either.left(BackEndError());
            }
            return Either.right('DONE');
          }),
        );
  }
}
