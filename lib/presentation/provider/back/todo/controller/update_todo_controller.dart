import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'update_todo_controller.g.dart';

@riverpod
class UpdateTodoController extends _$UpdateTodoController {
  @override
  Either<BackEndError, String> build() {
    return Either.right('');
  }

  void executeUpdateTodo({
    required String todoId,
    required String title,
    required String description,
    required DateTime period,
    required int priority,
    required String type,
    required String audioUrl,
    required bool isCompleted,
    required FToast toast,
  }) {
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(todoUseCaseProvider)
              .executeUpdateTodo(
                todoId: todoId,
                title: title,
                description: description,
                period: period,
                priority: priority,
                type: type,
                audioUrl: audioUrl,
                isCompleted: isCompleted,
              )
              .then((value) {
            if (value.isRight()) {
              value.getRight().fold(() => null, (str) {
                state = Either.right(str);
              });
            } else if (value.isLeft()) {
              value.getLeft().fold(() => null, (error) {
                showToastMessage(
                  toast,
                  '😵‍💫 Something went wrong with updating todo',
                  ToastWidgetKind.error,
                );
                state = Either.left(BackEndError(statusCode: 404));
              });
            } else {
              showToastMessage(
                toast,
                '😵‍💫 Something went wrong',
                ToastWidgetKind.error,
              );
              state = Either.left(BackEndError(statusCode: 404));
            }
            return Either.right('DONE');
          }),
        );
  }
}
