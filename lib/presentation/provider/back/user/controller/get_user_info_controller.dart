import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/user_info.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/page/dialogs/to_sign_up_dialog.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/user/providers.dart';

part 'get_user_info_controller.g.dart';

@riverpod
class GetUserInfoController extends _$GetUserInfoController {
  @override
  Either<BackEndError, UserInfo> build() {
    return Either.left(BackEndError(statusCode: 100));
  }

  void executeGetUserInfo({
    required FToast toast,
    required BuildContext context,
  }) {
    final token = ref.watch(authSharedPreferenceProvider);
    ref.read(userUseCaseProvider).executeGetUserInfo(token).then((value) {
      if (value.isRight()) {
        value.getRight().fold(() => null, (userInfo) {
          state = Either.right(userInfo);
        });
      } else {
        value.getLeft().fold(() => null, (error) {
          state = Either.left(error);
          // done make a dialog to move to sign in page and show it here
          if (error.statusCode == null || error.statusCode == 404) {
            // NOTE if the user access token is expired or something went wrong, I'll show you this dialog to go to sign up page
            showToSignUpDialog(
              context,
              messageToShow:
                  'Something went wrong, please connect the wifi or sign in again.',
            );
            return;
          }
          showToastMessage(
            toast,
            error.message!.detail ?? '😵‍💫 Something went wrong',
            ToastWidgetKind.error,
          );
        });
      }
      return Either.right(UserInfo());
    });
  }
}
