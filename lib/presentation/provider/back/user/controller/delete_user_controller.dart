import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/user/providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'delete_user_controller.g.dart';

@riverpod
class DeleteUserController extends _$DeleteUserController {
  @override
  Either<BackEndError, String> build() {
    return Either.left(BackEndError(statusCode: 100));
  }

  void executeDeleteUser(FToast toast) {
    final token = ref.read(authSharedPreferenceProvider);
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(userUseCaseProvider)
              .executeDeleteUser(
                token: token,
              )
              .then((value) {
            if (value.isRight()) {
              value.getRight().fold(() => null, (str) {
                state = Either.right(str);
              });
              showToastMessage(
                toast,
                '💡 User Deleted',
                ToastWidgetKind.success,
              );
            } else if (value.isLeft()) {
              value.getLeft().fold(() => null, (error) {
                final errorMessage = error.message!.detail ??
                    'Something went wrong with deleting user';

                showToastMessage(
                  toast,
                  error.message!.detail ?? '😵‍💫 $errorMessage',
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
