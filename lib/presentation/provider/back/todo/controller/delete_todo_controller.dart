import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/todo/controller/goal_info_getter.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'delete_todo_controller.g.dart';

@riverpod
class DeleteTodoController extends _$DeleteTodoController {
  @override
  Either<BackEndError, String> build() {
    return Either.right('');
  }

  void executeDeleteTodo({
    required String todoId,
    required FToast toast,
  }) {
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(todoUseCaseProvider)
              .executeDeleteTodo(todoId: todoId)
              .then((value) {
            if (value.isRight()) {
              value.getRight().fold(() => null, (str) {
                state = Either.right(str);
              });
              showToastMessage(
                toast,
                '💡 TODO Deleted',
                ToastWidgetKind.success,
              );
              // NOTE get the latest todo again
              ref
                  .read(goalInfoGetterProvider.notifier)
                  .executeGetGoalInfo(toast: toast);
            } else {
              value.getLeft().fold(() => null, (error) {
                showToastMessage(
                  toast,
                  '😵‍💫 Something went wrong with deleting todo',
                  ToastWidgetKind.error,
                );
                state = Either.left(error);
              });
            }
            return Either.right('DONE');
          }),
        );
  }
}
