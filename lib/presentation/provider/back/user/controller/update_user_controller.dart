import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/user/controller/get_user_info_controller.dart';
import 'package:volcano/presentation/provider/back/user/providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'update_user_controller.g.dart';

final usernameProvider = Provider<String>((ref) {
  final username = ref
      .read(getUserInfoControllerProvider)
      .getRight()
      .fold(() => 'Who you are', (userInfo) {
    return userInfo.username ?? 'Who you are';
  });
  return username;
});

@riverpod
class UpdateUserController extends _$UpdateUserController {
  // TextEditingController usernameTextEditingController =
  //     TextEditingController();

  @override
  Either<BackEndError, String> build() {
    return Either.left(BackEndError(statusCode: 100));
  }

  void executeUpdateUser({
    required String email,
    // required String username,
    required String username,
    required String icon,
    required FToast toast,
  }) {
    final token = ref.read(authSharedPreferenceProvider);
    // print(usernameTextEditingController.text);
    if (username.isEmpty || email.isEmpty) {
      showToastMessage(
        toast,
        '😵‍💫 Username Must Have\nAt Least 1 Character',
        ToastWidgetKind.error,
      );
      return;
    }
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(userUseCaseProvider)
              .executeUpdateUser(
                token: token,
                email: email,
                username: username,
                icon: icon,
              )
              .then((value) {
            if (value.isRight()) {
              value.getRight().fold(() => null, (str) {
                state = Either.right(str);
              });
              showToastMessage(
                toast,
                '💡 User Updated',
                ToastWidgetKind.success,
              );
              // ref.read(getUserInfoControllerProvider.notifier);
              return value;
            } else {
              value.getLeft().fold(() => null, (error) {
                state = Either.left(error);
              });
              return value;
            }
          }),
        );
  }
}
